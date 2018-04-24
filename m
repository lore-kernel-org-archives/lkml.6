Return-Path: <kernel-hardening-return-13122-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZqDowifGLF6KGEiaj7C+Q/jANFUXfj7GNMe9bg7AqIK77tlF1C9yVYuLm4fZkqbjOg54YwR
ARC-Seal: i=1; a=rsa-sha256; t=1524600318; cv=none;
        d=google.com; s=arc-20160816;
        b=b7CIR/z27bosOKsCR+GlmnNmPIVtVDNI7NfCii1oyeB3dQ6GuEtvKPQGdRW7+VyJY2
         kWgeswelfAxJhZkVvp3TmSVJvqRhI5p2a76uskNj9spKWj3PFaTEavnlhDrl9f3q5zem
         uYbP55GnFVi4v8zEledWfO/bqnThwnHcXhW4GqVCQz47QrEdKtLATAN/hfFMfoAbzPe4
         gB+cwCN71CUUz2Z0AcUvTt9t/s05ajV6r9Tch6tkVt7ERatJOguZwejO3Fi31mxFFhfx
         cHEtViywLsygUzlYVdg9/l1jnlMsWEgqWl220GIm+NF0gz13zC1gbjqKjXxcQuiLyOVm
         uGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=PphvyhiO4+VeVZ6QmTSv//AFPv5nAv40xNxdVst0MeE=;
        b=U+XetFTtbVdOzszwmGSw2rTDmQRF1chZ2zuohVJhPf+T4cJ+wRn/piidh/coE2pHMC
         VDaM4/EwqcbHmT+qr9u8BtKSAMiSTbirvDTsWnox8+bvyNP8gOF1R/7YmLUuU2/XRl5G
         /93UDyUcgmX2vidXYy8CrhrKok2XCbpFCcdfF73N0LSucq6NwlLeuyjxuavM/i3Wgr8+
         DtG08soEN1XpEuXkgzrYEnXoxD772b9MN2J5rDhnynF3AP6wLWwYXXgG0WsCtGwVWQuE
         ZLrTtXIMx5GnRF2bkmlPDAQVAb5PTsVYxDadS7t4uyBjMuDAwpNALidahzmostF1yUQO
         rxFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DsHV+bn9;
       dkim=pass header.i=@chromium.org header.s=google header.b=hvp8kvlF;
       spf=pass (google.com: domain of kernel-hardening-return-13122-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13122-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=DsHV+bn9;
       dkim=pass header.i=@chromium.org header.s=google header.b=hvp8kvlF;
       spf=pass (google.com: domain of kernel-hardening-return-13122-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13122-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180424195845.GB23575@mail.hallyn.com>
References: <20180424010321.14739-1-tycho@tycho.ws> <20180424045015.GA4281@sol.localdomain>
 <20180424143539.GB3125@cisco> <201804242346.FHI69745.SQMHFVOOFLFOJt@I-love.SAKURA.ne.jp>
 <20180424145104.GC3125@cisco> <20180424195845.GB23575@mail.hallyn.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 24 Apr 2018 13:04:58 -0700
X-Google-Sender-Auth: ekIlYw7uXsNP9cBHuyX0C85wXLM
Message-ID: <CAGXu5j+SXCJpm9xnX1UaY0Qz2+E0qNETc+s8kwrH6hE9LLjgpw@mail.gmail.com>
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Tycho Andersen <tycho@tycho.ws>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Eric Biggers <ebiggers3@gmail.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, James Morris <jmorris@namei.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598659303640331722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 12:58 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> Quoting Tycho Andersen (tycho@tycho.ws):
>> On Tue, Apr 24, 2018 at 11:46:38PM +0900, Tetsuo Handa wrote:
>> > Tycho Andersen wrote:
>> > > > > +     if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
>> > > > > +             WARN(1, "big key algorithm changed?");
>> >
>> > Please avoid using WARN() WARN_ON() etc.
>> > syzbot would catch it and panic() due to panic_on_warn == 1.
>>
>> But it is really a programming bug in this case (and it seems better
>> than BUG()...). Isn't this exactly the sort of case we want to catch?
>>
>> Tycho
>
> Right - is there a url to some discussion about this?  Because not
> using WARN when WARN should be used, because it troubles a bot, seems
> the wrong solution.  If this *is* what's been agreed upon, then
> what is the new recommended thing to do here?

BUG() is basically supposed to never be used, as decreed by Linus.
WARN() here is entirely correct: if we encounter a case where
crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE is not true, we
run the risk of stack memory corruption. If this is an EXPECTED
failure case, then okay, drop the WARN() but we have to keep the
-EINVAL.

-Kees

-- 
Kees Cook
Pixel Security
