Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226XSVdpGrFSxPw4LU0I0IoUToexXhzff7OTsU3aV46KWE6wGt8VIXU1lsbdgxLXwj2N7SnR
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=tUzM9nEVwtVHFhBrqkVlCdkBGvchBBN+EPbcL8+hWrP1v4UQ2+v0zAsszTMBTqJsx+
         WbV2zcTuLkUuzsa8HKg5BFq7OBNkyxORg7TH9m90rRLeT49k+FPiCGju2ixG9UGSBKU4
         DJ1zXQW0SXTZsX7RcfqapPoCcOZCtwFYXgAbgeNHOXpnaYpe2PfIW4knKwkTzXArAjyC
         STKbBck8W7VX1YzSCRWIII8Ika4/nVI66aXEFgp0yWD5Xdp050dDP/TaCZYrnk5yNvmH
         XcUE0jghoKaHQJhlxwJ3H6i9aA83m5VS5DGkg7vpfr6Ns1LmzZk2bijcP7K/lG8Bm1QK
         UiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=bqIObxmbs+IzgdDGruZRzcflE0S0IiR14juIeTQmYtc=;
        b=BD2hB1Z4+/Jktl9vX/7V9fDMeeBkjRX2gUko6HgvNuGAqs7VJ9hCw2LsLb3grq/ggJ
         34hTOVpJVM72fa6Vk6SZFMoVfQ7unIxH521xwz+0wtD/LR/CnwD5vfc/U5zf4RLggcH/
         3vAhb1Q7EnFmIMbIKOKhQYNHjIhBndqEEXxzJbU5BqOuQPxJ6qa1PHjH8LEmo4Erc3EI
         Zf7MotwhGf+7f1qtGGuK1qo+SjCs3wbCkk58dZG7LgvpmtZ7QwziUc7wO+fnxJ55E0cI
         qDKeMLj+A4pjnU30fu/3nanEn63CquQpqlrcXiWCGPhiqR4iBzZzJwpAa0QVXC7Cv5Sy
         pOgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=T6Xwwla2;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=T6Xwwla2;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAj011351
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marc Herbert <marc.herbert@intel.com>
Subject: [PATCH 04/14] kconfig: print additional new line for choice for redirection
Date: Tue,  6 Feb 2018 09:34:44 +0900
Message-Id: <1517877294-4826-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778754475982?=
X-GMAIL-MSGID: =?utf-8?q?1591609778754475982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If stdout is redirected to a file, prompts look differently due to
missing new lines.

Currently, conf_askvalue() takes care of this by putting additional
new line, but conf_choice() does not.  Do likewise so that prompts
after 'choice' look properly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index d346642..6ce06c8 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -317,6 +317,8 @@ static int conf_choice(struct menu *menu)
 		case oldaskconfig:
 			fflush(stdout);
 			xfgets(line, sizeof(line), stdin);
+			if (!tty_stdio)
+				printf("\n");
 			strip(line);
 			if (line[0] == '?') {
 				print_help(menu);
-- 
2.7.4
