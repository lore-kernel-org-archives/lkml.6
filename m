Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC2C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C642084C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VHICqNvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C642084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933156AbeGHVMk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:12:40 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42222 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932760AbeGHVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:12:38 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so15314953ioh.9;
        Sun, 08 Jul 2018 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2/2vgTlMgd/ReJREcGtP8JMIyOuniiSjvnor6BJkF4=;
        b=VHICqNvkVzP9jEkj/eA+OZfCjLAozG6QsMrfuUQbKDaULmr7NT1rAsLP3IykVi2QSc
         oXaqTQcQGULaEsT1VuqaUXCoGcX2q75kNR9Cam9Wk4R/RTYC+hnBBiOsqHiIcqtw/Fei
         shzFq4AUTNDyMrbTXbNXaeOtszv/FvLbpU1VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2/2vgTlMgd/ReJREcGtP8JMIyOuniiSjvnor6BJkF4=;
        b=braaq8nw/MJpydRKCaI+HosDWVVzkKF1aNcITUTC7IHGOBIOCvPfr8BPm7AnYURcSN
         rkpLG9CjiXNCLGFCyVse5tEitPg/TixWWp2YVIueOkcl+BeYAIdi0loR6BGhNPMOmPR4
         mXG2fCMxxDVn42jRO66bk1cP0abENGUzI+oF9r0nAGv4JtqwTPJjiqQXpAq9ONb5/hO6
         J6pvPYejZgxvBdHRUT5rqdUKk0qbTmpbQ64CNYwpAs7VU/HUksHhSQbbZ6P93MGXePKk
         mRlr8nYamEV/sEFEXDAW17vkACCproOhEN9Flo1jbzHScS0QPgUW3E8OZ3Ww5SOkH83R
         GGwg==
X-Gm-Message-State: AOUpUlFCa31/HXY86K/kdBGuJ/yLU9jbsGK47NjXzcXKw0FniOADDkk3
        du/kZxJYaiNDPCVY73x9+OZJTcP0rjW6Qtx8XRk=
X-Google-Smtp-Source: AAOMgpdDF3g4x+Pnnn+N495bgFkqoYOr1jNojZLXj9CaPRD6djyTB3Y/jlCVJ+FHMzsLHbuhMiU9lTpkuPB1Pbzst1E=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr15906178ion.259.1531084358050;
 Sun, 08 Jul 2018 14:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Jul 2018 14:12:27 -0700
Message-ID: <CA+55aFzgnTMzssSKEkoLy+Mh29aAa4sFXiV=ouXZ8ivVKEJomw@mail.gmail.com>
Subject: Re: [PATCH for 4.18 0/6] Restartable Sequences updates
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 8, 2018 at 2:03 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Following the recent discussion thread [1] about rseq uapi, here is
> a set of updates submitted for integration into 4.18. Those change all
> rseq __get_user/__put_user for get_user/put_user as discussed.

LGTM, FWIW. I didn't test it, but the patches look sane.

         Linus
