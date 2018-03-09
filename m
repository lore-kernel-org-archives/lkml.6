Return-Path: <kernel-hardening-return-12310-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvK2eIWsJq7cgihgSUBY0V8jhCMTt97xaagabPB8X4GLbHJAxddgE0nwcJ4MAASwtyBloR9
ARC-Seal: i=1; a=rsa-sha256; t=1520591850; cv=none;
        d=google.com; s=arc-20160816;
        b=Cm/m0maYkEO03DpDyu9SpVp/QbRnGHE+vsyde0pZAaWGk2BHP/EG/Nas0Sr+/AT8Xi
         RWnTU/wMGQHHsFHZiyDWGCGAVUxlnvE5PygNSLav+T7Ny1+mzL9lamfFAtNi5lLeth9C
         IzIVH6nAaehmRXlhqxg1QIOengUeBx8YMHSjaBkvHHikWOfQzaD6iJ/8ry+56HTcAm4j
         /77sKYK7s1Tg4kRD3IeDIfIi7CgrYKBYI2MkdxiRWilyz97c/1gYb4qDUxWuvLtC+evH
         Yj0IaIiqOZTCe99YK4KP2/fhNTe5NigoZn3X6+y5Vkh8StXPS8QvGapH7mht3IWhqXSd
         4o3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=T/qI0GgYvdHDzhZkmuPBh/0M2Pja3n60nEj46mUdasE=;
        b=NEeU75RZeU0wrFzr49qb5jwjCul2+Ufz63ot7QfKwamlxB1s42HOimEAsgueCMTX8t
         TZmx69hDXU+C2cZM9o5TFzVdJ1SwH3tL3Jd0cmh6Eesf9ME8yIFrhNkBs6DsZ68vVarp
         aIuVwK1g8wBq82eQi9WjRZI9nO/QkNEWMXDdebJ6eI6T8VusCZ8sg3K28dZFB2eJyz7z
         7Ls+JpVvur9rkDLAT27olLpgXrYJU6MAEWz2eQ3n76bkOAJVmsTtRRyatoovYlcJaSJc
         KdY26Bj3n5GS02LENoz2j0uY00GSH1QY7o76aFxdNCWmMiU9pfkxUXv/lkASrtEJ+Ykk
         1szA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UbpjD1tw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UgWofkUi;
       spf=pass (google.com: domain of kernel-hardening-return-12310-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12310-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UbpjD1tw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UgWofkUi;
       spf=pass (google.com: domain of kernel-hardening-return-12310-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12310-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17BF56016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: kernel-hardening@lists.openwall.com,  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,  Tycho Andersen <tycho@tycho.ws>,  Kees Cook <keescook@chromium.org>,  "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] rsi: Remove stack VLA usage
References: <1520577493-24603-1-git-send-email-me@tobin.cc>
Date: Fri, 09 Mar 2018 12:37:06 +0200
In-Reply-To: <1520577493-24603-1-git-send-email-me@tobin.cc> (Tobin C.
	Harding's message of "Fri, 9 Mar 2018 17:38:13 +1100")
Message-ID: <87r2ota625.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594456120183302264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Tobin C. Harding" <me@tobin.cc> writes:

> The kernel would like to have all stack VLA usage removed[1].  rsi uses
> a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> is defined using a magic number.  We can use a pre-processor defined
> constant and declare the array to maximum size.  We add a check before
> accessing the array in case of programmer error.
>
> [1]: https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Please CC linux-wireless list, otherwise patchwork won't see the patch
and I can't apply it.

-- 
Kalle Valo
