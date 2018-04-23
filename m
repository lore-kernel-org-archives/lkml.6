Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755164AbeDWM6j convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:58:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754913AbeDWM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:58:33 -0400
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <89ca9f7d20c24a3d9c743c7f5ca2d108@SIWEX5A.sing.micron.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 23 Apr 2018 14:58:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <89ca9f7d20c24a3d9c743c7f5ca2d108@SIWEX5A.sing.micron.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18042312-0020-0000-0000-00000414E94B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042312-0021-0000-0000-000042A94611
Message-Id: <3298b85a-6a64-3b12-93c6-989c166bfb53@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/17/2018 12:00 PM, Bean Huo (beanhuo) wrote:

> #Cat trace
> iozone-4055  [000] ....   665.039276: block_unplug: [iozone] 1 Sync
> iozone-4055  [000] ...1   665.039278: block_rq_insert: 8,48 WS 0 () 39604352 + 128 tag=18 [iozone]
> iozone-4055  [000] ...1   665.039280: block_rq_issue: 8,48 WS 0 () 39604352 + 128 tag=18 [iozone]
> iozone-4055  [000] ...1   665.039284: scsi_dispatch_cmd_start: host_no=0 channel=0 id=0 lun=3 data_sgl=16 prot_sgl=0 prot_op=SCSI_PROT_NORMAL tag=18 cmnd=(WRITE_10 lba=4950544 txlen=16 protect=0 raw=2a 00 00 4b 8a 10 00 00 10 00)
> iozone-4056  [002] ....   665.039284: block_dirty_buffer: 8,62 sector=44375 size=4096
> <idle>-0     [000] d.h2   665.039319: scsi_dispatch_cmd_done: host_no=0 channel=0 id=0 lun=3 data_sgl=16 prot_sgl=0 prot_op=SCSI_PROT_NORMAL tag=24 cmnd=(WRITE_10 lba=4944016 txlen=16 protect=0 raw=2a 00 00 4b 70 90 00 00 10 00) result=(driver=DRIVER_OK host=DID_OK message=COMMAND_COMPLETE status=SAM_STAT_GOOD)
> <idle>-0     [000] d.h3   665.039321: block_rq_complete: 8,48 WS () 39552128 + 128 tag=24 [0]

> iozone-4058  [003] ....   665.039362: block_bio_remap: 8,48 WS 39568768 + 128 <- (8,62) 337280
> iozone-4058  [003] ....   665.039364: block_bio_queue: 8,48 WS 39568768 + 128 [iozone]
> iozone-4058  [003] ...1   665.039366: block_getrq: 8,48 WS 39568768 + 128 [iozone]

I'm not familiar with block/scsi command tagging.

Some block events now would get a tag field.
Some block events would not get a tag field (maybe because for some the 
tag is not (yet) known).

So all block events that belong to the same request would still need to 
be correlated by something like (devt, RWBS, LBA, length) because not 
all have a tag field.

> Especially, the ftrace log with tag information, I can easily figure out one I/O request between block layer and SCSI.

Provided this is done correctly, I would be in favor of a solution.
Since
v4.11 commit 48b77ad60844 (``block: cleanup tracing'')\newline
v4.11 commit 82ed4db499b8 (``block: split scsi\_request out of struct 
request'')
we don't have the SCSI CDB in block traces (nor in blktrace traditional 
relayfs trace format, nor in ftrace 'blk' tracer binary synthesized 
output [1]) any more (empty Packet Command payload).
Being able to correlate block events with scsi events would indeed be 
very helpful for some cases.

Is a correlation between block and scsi only necessary for these pairs?:

block_rq_issue causes scsi_dispatch_cmd_start, and
scsi_dispatch_cmd_done causes block_rq_complete.

If so, only those two block trace events would need to get a new field?


[1] v2.6.30 commit 08a06b83ff8b (``blkftrace: binary tracing, 
synthesizing old format'')
     v2.6.31 commit f3948f8857ef (``blktrace: fix context-info when 
mixed-using blk tracer and trace events'')

-- 
Mit freundlichen Grüßen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
