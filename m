Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D64C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFB22080D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBLL4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:56:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43129 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:56:11 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gtWfQ-0001pO-85; Tue, 12 Feb 2019 12:56:00 +0100
Date:   Tue, 12 Feb 2019 12:55:59 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     Aubrey Li <aubrey.li@intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
In-Reply-To: <7cf6f2bb-780d-5c0d-ac3f-e88ced3a0404@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1902121254340.3710@nanos.tec.linutronix.de>
References: <20190211185931.4386-1-aubrey.li@intel.com> <20190211185931.4386-2-aubrey.li@intel.com> <alpine.DEB.2.21.1902120905420.1654@nanos.tec.linutronix.de> <efe3e5c9-c477-8a28-5489-c943fe63efaa@linux.intel.com> <alpine.DEB.2.21.1902121215590.3710@nanos.tec.linutronix.de>
 <7cf6f2bb-780d-5c0d-ac3f-e88ced3a0404@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1191058316-1549972560=:3710"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1191058316-1549972560=:3710
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 Feb 2019, Li, Aubrey wrote:
> On 2019/2/12 19:19, Thomas Gleixner wrote:
> > On Tue, 12 Feb 2019, Li, Aubrey wrote:
> >> On 2019/2/12 16:22, Thomas Gleixner wrote:
> >>> On Tue, 12 Feb 2019, Aubrey Li wrote:
> >>>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> >>>> index d53c54b842da..60ee932070fe 100644
> >>>> --- a/arch/x86/include/asm/processor.h
> >>>> +++ b/arch/x86/include/asm/processor.h
> >>>> @@ -996,5 +996,7 @@ enum l1tf_mitigations {
> >>>>  };
> >>>>  
> >>>>  extern enum l1tf_mitigations l1tf_mitigation;
> >>>> +/* Add support for architecture specific output in /proc/pid/status */
> >>>> +extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
> >>>
> >>> Sigh. This is absolutely the wrong place. The weak function is declared and
> >>> used in fs/proc/... So the prototype wants to be in a header which is
> >>> included from there independent of x86...
> >>
> >> Can the prototype be in the architecture header if they want to call the
> >> function?
> > 
> > Basic C programming course:
> > 
> >  The prototype must be available before the declaration of the global
> >  function.
> > 
> > fs/proc/array.c:404:13: warning: no previous prototype for ‘arch_proc_pid_status’ [-Wmissing-prototypes]
> >  void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
> > 
> > Oh well....
> 
> Is this because patch 1/3 applied alone? If the whole patch set are applied,
> the prototype is included in <asm/processor.h>, which is at the beginning of
> array.c file, so it is available before the declaration.

1) Each patch has to be correct stand alone

2) This file is compiled for every architecture the kernel supports and how
   many of them are including arch/x86/include/asm/processor.h ?

   There is a world outside x86 and it's rather large.

Thanks,

	tglx
--8323329-1191058316-1549972560=:3710--
