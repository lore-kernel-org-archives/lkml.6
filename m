Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A13C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16FB204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16FB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeICT5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:57:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:22499 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICT5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:57:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 08:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="70237170"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2018 08:36:41 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4114C301B65; Mon,  3 Sep 2018 08:36:41 -0700 (PDT)
Date:   Mon, 3 Sep 2018 08:36:41 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Wes Turner <wes.turner@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "jsteckli@amazon.de" <jsteckli@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "juerg.haefliger@hpe.com" <juerg.haefliger@hpe.com>,
        "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
Message-ID: <20180903153641.GF27886@tassilo.jf.intel.com>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
 <CACfEFw_h5uup-anKZwfBcWMJB7gHxb9NEPTRSUAY0+t11RiQbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACfEFw_h5uup-anKZwfBcWMJB7gHxb9NEPTRSUAY0+t11RiQbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 06:33:22PM -0400, Wes Turner wrote:
>    Speaking of pages and slowdowns,
>    is there a better place to ask this question:
>    From "'Turning Tables' shared page tables vuln":
>    """
>    'New "Turning Tables" Technique Bypasses All Windows Kernel Mitigations'
>    https://www.bleepingcomputer.com/news/security/new-turning-tables-technique-bypasses-all-windows-kernel-mitigations/
>    > Furthermore, since the concept of page tables is also used by Apple and
>    the Linux project, macOS and Linux are, in theory, also vulnerable to this
>    technique, albeit the researchers have not verified such attacks, as of
>    yet.
>    Slides:
>    https://cdn2.hubspot.net/hubfs/487909/Turning%20(Page)%20Tables_Slides.pdf
>    Naturally, I took notice and decided to forward the latest scary headline
>    to this list to see if this is already being addressed?

This essentially just says that if you can change page tables you can subvert kernels.
That's always been the case, always will be, I'm sure has been used forever by root kits,
and I don't know why anybody would pass it off as a "new attack".

-Andi
