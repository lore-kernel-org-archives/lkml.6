Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDMQ7u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:59:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeDMQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:59:48 -0400
To: Jinpu Wang <jinpu.wang@profitbricks.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Elliott\, Robert \(Persistent Memory\)" <elliott@hpe.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2] block: ratelimite pr_err on IO path
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com>
        <yq1y3hsunnt.fsf@oracle.com>
        <CAMGffEkaTLLEs+i-EWUmo-Y8KSNBeyth63L1hXxP++PBcPPXbg@mail.gmail.com>
Date: Fri, 13 Apr 2018 12:59:38 -0400
In-Reply-To: <CAMGffEkaTLLEs+i-EWUmo-Y8KSNBeyth63L1hXxP++PBcPPXbg@mail.gmail.com>
        (Jinpu Wang's message of "Fri, 13 Apr 2018 10:37:25 +0200")
Message-ID: <yq1bment539.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=651
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804130156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinpu,

[CC:ed the mpt3sas maintainers]

The ratelimit patch is just an attempt to treat the symptom, not the
cause.

> Thanks for asking, we updated mpt3sas driver which enables DIX support
> (prot_mask=0x7f), all disks are SATA SSDs, no DIF support.
> After reboot, kernel reports the IO errors from all the drives behind
> HBA, seems for almost every read IO, which turns the system unusable:
> [   13.079375] sda: ref tag error at location 0 (rcvd 143196159)
> [   13.079989] sda: ref tag error at location 937702912 (rcvd 143196159)
> [   13.080233] sda: ref tag error at location 937703072 (rcvd 143196159)
> [   13.080407] sda: ref tag error at location 0 (rcvd 143196159)
> [   13.080594] sda: ref tag error at location 8 (rcvd 143196159)

That sounds like a bug in the mpt3sas driver or firmware. I guess the
HBA could conceivably be operating a SATA device as DIX Type 0 and strip
the PI on the drive side. But that doesn't seem to be a particularly
useful mode of operation.

Jinpu: Which firmware are you running? Also, please send us the output
of:

        sg_readcap -l /dev/sda
        sg_inq -x /dev/sda
        sg_vpd /dev/sda

Broadcom: How is DIX supposed to work for SATA drives behind an mpt3sas
controller?

-- 
Martin K. Petersen	Oracle Linux Engineering
