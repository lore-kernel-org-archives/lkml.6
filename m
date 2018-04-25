Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx496c9nGUD+M9J3jHCnNwT/7+5admp+2Prmvm+pOXsXxj/UQnQdPJPcXqq0adrGQYhgJ/KQt
ARC-Seal: i=1; a=rsa-sha256; t=1524652763; cv=none;
        d=google.com; s=arc-20160816;
        b=Lut5+LSIiK+ADPSzgqBaUdI6OCZZKFXaGwR2TuLTGf2fYe33Ala6oOgPPrZThQJEXj
         Vm6p79/MfIccy5Zs6mdqDQSxOjppEOgdj2E4NOIf085U//O/yE61GxQJOYjaZDZGKNh2
         BjRkjmRW6UfeoiLdj8HB2o8PZSGr2OLoHJm+KN/O65q3zVzo03ZBCTZTkfNM1Fgp1Lhx
         XwXgVAF2AZAW84hRsFZao3wDFZFnDHIT0EhLx3BKiOLlX8EpyVbtTMSxvul/8em8+0mf
         C/cb9NTne+K94/C/zY8eWrNj+1dG9oMWxPemq4yFLKPchadOvDS6K6drqKyyQ6sGdRB7
         NWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QfJKFDDN4OuY7EPhAthaXws1j2OFVbrxR3jWMVIuMjk=;
        b=FF7zjtCaULqKzx96vRO26Jsfq4clbb2KNKC7zTzzkw5ZN740YRgF2W9zFIhM1g4w2N
         wsAGcizpPWD6bDh8HESBbTgG0KEHj5HmNANRFojmIOUrkJWYVaMX1syLnXt1Da5BaElF
         hPaDKRLh0cuk8qAo0OxQKjjuI2nUKgkdgjnguwHzxlkIPotluXTYlJ0MU5vcOpMnAWhK
         Pc6iPdYbbVG9Nvv4KVCUuaYx8OZbv93+A3BRsP2sLCp4R87HAJISnPowUctbubIYL96Z
         KwBtuFt2D8U46sZx9/42vLiN4U1OPKcKRFKhXVv86ThsKT5nZaPilEnD0c0NGDLrDya2
         mhNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 059/183] kconfig: Fix automatic menu creation mem leak
Date: Wed, 25 Apr 2018 12:34:39 +0200
Message-Id: <20180425103244.907393788@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714296227906803?=
X-GMAIL-MSGID: =?utf-8?q?1598714296227906803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>


[ Upstream commit ae7440ef0c8013d68c00dad6900e7cce5311bb1c ]

expr_trans_compare() always allocates and returns a new expression,
giving the following leak outline:

	...
	*Allocate*
	basedep = expr_trans_compare(basedep, E_UNEQUAL, &symbol_no);
	...
	for (menu = parent->next; menu; menu = menu->next) {
		...
		*Copy*
		dep2 = expr_copy(basedep);
		...
		*Free copy*
		expr_free(dep2);
	}
	*basedep lost!*

Fix by freeing 'basedep' after the loop.

Summary from Valgrind on 'menuconfig' (ARCH=x86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 344,376 bytes in 14,349 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kconfig/menu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -372,6 +372,7 @@ void menu_finalize(struct menu *parent)
 			menu->parent = parent;
 			last_menu = menu;
 		}
+		expr_free(basedep);
 		if (last_menu) {
 			parent->list = parent->next;
 			parent->next = last_menu->next;
