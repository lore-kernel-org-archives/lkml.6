Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC31E2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybernetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbeGKOQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:16:30 -0400
Received: from mail.cybernetics.com ([173.71.130.66]:35014 "EHLO
        mail.cybernetics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeGKOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:16:29 -0400
X-Greylist: delayed 938 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2018 10:16:29 EDT
X-ASG-Debug-ID: 1531317381-0fb3b01fb32aeba0001-xx1T2L
Received: from cybernetics.com ([10.157.1.126]) by mail.cybernetics.com with ESMTP id MpIjCgurxK8lRpTh (version=SSLv3 cipher=DES-CBC3-SHA bits=112 verify=NO); Wed, 11 Jul 2018 09:56:21 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
Received: from [10.157.2.224] (account tonyb HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 5.1.14)
  with ESMTPSA id 8275324; Wed, 11 Jul 2018 09:56:21 -0400
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     Christoph Hellwig <hch@infradead.org>
X-ASG-Orig-Subj: Re: [GIT PULL] SCSI fixes for 4.18-rc3
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com>
 <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
 <70d566f0-2dda-60c2-7c7a-e09e371f8607@cybernetics.com>
 <20180711064542.GA7377@infradead.org>
From:   Tony Battersby <tonyb@cybernetics.com>
Message-ID: <16922cb7-757e-dc25-bc5a-ee6e48538b13@cybernetics.com>
Date:   Wed, 11 Jul 2018 09:56:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711064542.GA7377@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Barracuda-Connect: UNKNOWN[10.157.1.126]
X-Barracuda-Start-Time: 1531317381
X-Barracuda-Encrypted: DES-CBC3-SHA
X-Barracuda-URL: https://10.157.1.122:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 3022
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 02:45 AM, Christoph Hellwig wrote:
> On Tue, Jul 10, 2018 at 05:53:18PM -0400, Tony Battersby wrote:
>> At my job (https://www.cybernetics.com/), I use the write()/read()
>> interface to the SCSI generic driver for access to tape drives and tape
>> medium changers.  For example, the write()/read() interface is useful
>> for implementing RAID-like functionality for tape drives since a single
>> thread can send commands to multiple tape drives at once and poll() for
>> command completion.  We have a lot of code invested in this interface,
>> so it would be a huge pain for us if it were removed.  But in our case,
>> everything runs as root (as the firmware of an embedded storage
>> appliance), so extra permission checks should be OK.
> Do you just use read/write on /dev/sg or also on /dev/bsg?  Because
> I started a discussion to kill the read/write support for the latter
> even before Linus brought it up here..  (and we have the same fix
> pending for /dev/bsg)
>
The read/write interface on /dev/bsg is impossible to use safely because
the list of completed commands is per-device (bd->done_list) rather than
per-fd like it is with /dev/sg.  So if program A and program B are both
using the write/read interface on the same bsg device, then their
command responses will get mixed up, and program A will read() some
command results from program B and vice versa.  So no, I don't use
read/write on /dev/bsg.  From a security standpoint, it should
definitely be fixed or removed.

Another issue with the read/write interface of /dev/bsg was this:

[PATCH] [SCSI] bsg: fix unkillable I/O wait deadlock with scsi-mq
https://marc.info/?l=linux-scsi&m=142367231311098&w=2

My similar patch to sg.c was accepted as commit 7568615c1054 ("sg: fix
unkillable I/O wait deadlock with scsi-mq"), but my bsg patch was never
applied.  I do not know if the problem still exists in the current
kernel or if some other change to scsi-mq has fixed it.  I do have a
forward-port of the patch to 4.16, but it no longer applies to 4.17.

---

A while ago there was a commit that broke the read/write interface of
/dev/sg (but not SG_IO), and some other people complained in the
following bugzilla entry, indicating that there are other users also:

https://bugzilla.kernel.org/show_bug.cgi?id=198081

The commit that broke it was:
109bade9c625 ("scsi: sg: use standard lists for sg_requests")

The commit that fixed it was:
48ae8484e9fc ("scsi: sg: don't return bogus Sg_requests")
(sg_get_rq_mark() is called only from sg_read(), so if the patch fixed
the problem that people were complaining about in bugzilla, then that
indicates that they are using the read/write interface also)

See my explanation here:
https://marc.info/?l=linux-scsi&m=152227354106242
(basically, the commit that broke it got backported to -stable, but the
fix didn't, so various -stable kernels were broken for a while, and
people complained)

Tony Battersby
Cybernetics

