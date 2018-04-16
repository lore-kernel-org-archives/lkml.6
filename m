Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeDPIQc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:16:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43265 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753813AbeDPIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:16:29 -0400
X-Google-Smtp-Source: AIpwx4++TSKeHoDNdI7XtfstS4AAGyn8+JfVUFpTfIssSvQ7JZKUw777cKmTecG4eE0mXaZW84Z4CBwQe19RAMLnrvE=
MIME-Version: 1.0
In-Reply-To: <yq1bment539.fsf@oracle.com>
References: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com>
 <yq1y3hsunnt.fsf@oracle.com> <CAMGffEkaTLLEs+i-EWUmo-Y8KSNBeyth63L1hXxP++PBcPPXbg@mail.gmail.com>
 <yq1bment539.fsf@oracle.com>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Mon, 16 Apr 2018 10:16:07 +0200
Message-ID: <CAMGffEkbXORH+baoVRD4fOLk=hV6P-oXRpobM6A+o_fCADkbdQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: ratelimite pr_err on IO path
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 6:59 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Jinpu,
>
> [CC:ed the mpt3sas maintainers]
>
> The ratelimit patch is just an attempt to treat the symptom, not the
> cause.
Agree. If we can fix the root cause, it will be great.
>
>> Thanks for asking, we updated mpt3sas driver which enables DIX support
>> (prot_mask=0x7f), all disks are SATA SSDs, no DIF support.
>> After reboot, kernel reports the IO errors from all the drives behind
>> HBA, seems for almost every read IO, which turns the system unusable:
>> [   13.079375] sda: ref tag error at location 0 (rcvd 143196159)
>> [   13.079989] sda: ref tag error at location 937702912 (rcvd 143196159)
>> [   13.080233] sda: ref tag error at location 937703072 (rcvd 143196159)
>> [   13.080407] sda: ref tag error at location 0 (rcvd 143196159)
>> [   13.080594] sda: ref tag error at location 8 (rcvd 143196159)
>
> That sounds like a bug in the mpt3sas driver or firmware. I guess the
> HBA could conceivably be operating a SATA device as DIX Type 0 and strip
> the PI on the drive side. But that doesn't seem to be a particularly
> useful mode of operation.
>
> Jinpu: Which firmware are you running? Also, please send us the output
> of:
>
>         sg_readcap -l /dev/sda
>         sg_inq -x /dev/sda
>         sg_vpd /dev/sda
>
Disks are INTEL SSDSC2BX48, directly attached to HBA.
LSISAS3008: FWVersion(13.00.00.00), ChipRevision(0x02), BiosVersion(08.11.00.00)
mpt3sas_cm2: Protocol=(Initiator,Target),
Capabilities=(TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set
Full,NCQ)

jwang@x:~$ sudo sg_vpd /dev/sdz
Supported VPD pages VPD page:
  Supported VPD pages [sv]
  Unit serial number [sn]
  Device identification [di]
  Mode page policy [mpp]
  ATA information (SAT) [ai]
  Block limits (SBC) [bl]
  Block device characteristics (SBC) [bdc]
  Logical block provisioning (SBC) [lbpv]
jwang@x:~$ sudo sg_inq -x /dev/sdz
VPD INQUIRY: extended INQUIRY data page
    inquiry: field in cdb illegal (page not supported)
jwang@x:~$ sudo sg_readcap -l /dev/sdz
Read Capacity results:
   Protection: prot_en=0, p_type=0, p_i_exponent=0
   Logical block provisioning: lbpme=1, lbprz=1
   Last logical block address=937703087 (0x37e436af), Number of
logical blocks=937703088
   Logical block length=512 bytes
   Logical blocks per physical block exponent=3 [so physical block
length=4096 bytes]
   Lowest aligned logical block address=0
Hence:
   Device size: 480103981056 bytes, 457862.8 MiB, 480.10 GB


> Broadcom: How is DIX supposed to work for SATA drives behind an mpt3sas
> controller?
>
> --
> Martin K. Petersen      Oracle Linux Engineering


Thanks!

-- 
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin
