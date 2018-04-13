Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbeDMIhw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 04:37:52 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37952 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753361AbeDMIhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 04:37:47 -0400
X-Google-Smtp-Source: AIpwx49iOnFNQvwKBNwR0YnsuWSxZILCtCfB6old6HLvIAFHg4ZEFvXCLCTWED4lZ/Y/fUZCVTrs29t8VXKnE51MGpY=
MIME-Version: 1.0
In-Reply-To: <yq1y3hsunnt.fsf@oracle.com>
References: <1523524915-25170-1-git-send-email-jinpu.wangl@profitbricks.com> <yq1y3hsunnt.fsf@oracle.com>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Fri, 13 Apr 2018 10:37:25 +0200
Message-ID: <CAMGffEkaTLLEs+i-EWUmo-Y8KSNBeyth63L1hXxP++PBcPPXbg@mail.gmail.com>
Subject: Re: [PATCH v2] block: ratelimite pr_err on IO path
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 11:20 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Jack,
>
>> +                             pr_err_ratelimited("%s: ref tag error at location %llu (rcvd %u)\n",
>
> I'm a bit concerned about dropping records of potential data loss.
>
> Also, what are you doing that compels all these to be logged? This
> should be a very rare occurrence.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
Hi Martin,

Thanks for asking, we updated mpt3sas driver which enables DIX support
(prot_mask=0x7f), all disks are SATA SSDs, no DIF support.
After reboot, kernel reports the IO errors from all the drives behind
HBA, seems for almost every read IO, which turns the system unusable:
[   13.079375] sda: ref tag error at location 0 (rcvd 143196159)
[   13.079989] sda: ref tag error at location 937702912 (rcvd 143196159)
[   13.080233] sda: ref tag error at location 937703072 (rcvd 143196159)
[   13.080407] sda: ref tag error at location 0 (rcvd 143196159)
[   13.080594] sda: ref tag error at location 8 (rcvd 143196159)
[   13.080996] sda: ref tag error at location 0 (rcvd 143196159)
[   13.089878] sdb: ref tag error at location 0 (rcvd 143196159)
[   13.090275] sdb: ref tag error at location 937702912 (rcvd 277413887)
[   13.090448] sdb: ref tag error at location 937703072 (rcvd 143196159)
[   13.090655] sdb: ref tag error at location 0 (rcvd 143196159)
[   13.090823] sdb: ref tag error at location 8 (rcvd 277413887)
[   13.091218] sdb: ref tag error at location 0 (rcvd 143196159)
[   13.095412] sdc: ref tag error at location 0 (rcvd 143196159)
[   13.095859] sdc: ref tag error at location 937702912 (rcvd 143196159)
[   13.096058] sdc: ref tag error at location 937703072 (rcvd 143196159)
[   13.096228] sdc: ref tag error at location 0 (rcvd 143196159)
[   13.096445] sdc: ref tag error at location 8 (rcvd 143196159)
[   13.096833] sdc: ref tag error at location 0 (rcvd 277413887)
[   13.097187] sds: ref tag error at location 0 (rcvd 277413887)
[   13.097707] sds: ref tag error at location 937702912 (rcvd 143196159)
[   13.097855] sds: ref tag error at location 937703072 (rcvd 277413887)

Kernel version 4.15 and 4.14.28, I scan the commits in upstream,
haven't found any relevant.
in  4.4.112, there's no such errors.
Diable DIX support (prot_mask=0x7) in mpt3sas fixes the problem.

Regards,
-- 
Jack Wang
Linux Kernel Developer            ProfitBricks GmbH
