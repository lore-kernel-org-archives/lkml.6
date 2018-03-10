Return-Path: <kernel-hardening-return-12391-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsVqQ2A2Y7Jb3l5aO5+c+C2CZ4KCpDOnV/2LXcAiOzXNN8kda36BeBwIaKsB76ZX93/dJ1W
ARC-Seal: i=1; a=rsa-sha256; t=1520725494; cv=none;
        d=google.com; s=arc-20160816;
        b=qA0b5D/WW9xafVthfGig2Mol9qCSek+4NlmCZBzzp19u151HokWsTc6ehw2OFTxmWo
         ApjKhhHrSsJcfRpKWwF2rEsQCeh2kGRvJukKOnJuFSXG3U2Q2vpGvOgmbAllFqNduJGR
         JA3zDnKzgq48QeqJ5ku1PhEu8AR7ydtx5Gm0v/Hr4G7PDHLp4rUgWGJY0AKFVov87/gF
         FLlzZhJMW+KSYN5feNP48cwErp1xzTM8ueY3TXlGnR4B2xuStZSjAcLk9Zom89secvct
         oGKbqMqvytcGlJHOz7cFW6oskEX0oyXY9LaG1U6+wnSZSJIQ1CQdhDUqZVyss0iuJujT
         EUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=vod5ylk606SlZNQ+hSUtEnsQAEEkmpr6F+6bt48wmnI=;
        b=fbLzmujuchumFWdx+9+semm7XwFXiQUs0BSCDhPY0dPvoLM7gW9Bh8ebC77tOklInl
         CPcBPcTEUPwlfJAhx21pSuz6sJ+TPG2qYvGzw4TVOyFgs3BiSBFGYDIfYvN1bJpoaxxr
         untDsNXIYitAXO7aoFA0L8BzXwlfx0bcN1X8fLkj5NAubm7A2GUIKmTExO/5pWUdod6k
         kqKzj/JikJH9Xe6Dhi4ERKCaTwCBFb+DFHYnaw4wunczjE+ttRN2NlX7wubUNsmpuBxR
         xVPg86ZJ4Y/fDPZQTX8r9PYa89EdglbpN2Lw9gCoUDbjaEazuLYu3Fg06eofauyASmiG
         0LBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rGYtNEpT;
       spf=pass (google.com: domain of kernel-hardening-return-12391-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12391-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rGYtNEpT;
       spf=pass (google.com: domain of kernel-hardening-return-12391-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12391-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <5AA464DE.90100@broadcom.com>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com> <5AA464DE.90100@broadcom.com>
From: Daniel Micay <danielmicay@gmail.com>
Date: Sat, 10 Mar 2018 18:44:35 -0500
Message-ID: <CA+DvKQ+hbMoWJdOuQB5n+eVF4ePf=kVuRiMbdtTUZ8ars4Pz4A@mail.gmail.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>, Kees Cook <keescook@chromium.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594596256464451833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Just wondering. Is this actually a VLA. FFT_NUM_SAMPLES was static const so
> not really going to show a lot of variation. This array will always have the
> same size on the stack.

The issue is that unlike in C++, a `static const` can't be used in a
constant expression in C. It's unclear why C is defined that way but
it's how it is and there isn't currently a GCC extension making more
things into constant expressions like C++.
