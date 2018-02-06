Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224pFrBJOcAJnfIZIfZg0xX2yBQbsuO+OCBgI+B8hov/2axfKvA3d2MoGA9QXfVz1/aEVfX9
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=DP86Ce5SF2apRoVqn4TeaBISxL/cHHNBX1gkVNLNNigpiHAXQ98SH+Z9/ZiBh/f1EM
         uxplcJcAF5gqbBvWZPL5tmhSUgvj1cHL4n3dCFQe8aVK9GwcvNmBXOs9UPHlZIlchsfW
         Kkmi7Y1v6LgexDyz5u8kDMgFC5bk5VtbzhwLhMO5O9Jp9350CupMuekcU/D0LHohXV6U
         fxyd79i+bUxTzPPcA3NE+a61VGdZlWNdlgjd4kZwU9za6CojgofaQnc4C41b0ZmzMpYi
         UqBz470gzDQSm8CSZX4Dl9dGaIJKhAbRirMzyonM/DFSsogtavgcRUxbAupWom4FMeFX
         SDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=bLojHb0MdVijoOprmBRkaKTU1H/92xNDhc4zozTi0o8=;
        b=rFfMwddyYjpnEMN7sdSPfcyQDQT3Y9M1KXDpulfXxjaTb/fQMj3r4Yr0Qhr030dq+L
         qcHLRMgtPz/1Tbt5eLne5PDXwuS7Z1nHG/YtRjCiwQb2wftSHh0D4LiW2nbslRXaUrnX
         8lTKk7qSLUir5eURmYoSrkqk39l9i/UlVcn+b1apMlWvJgc1fsI6Q6RWb7Cq47NGy7gD
         NCVwcCalHsRLhllEwbsZE8GB+LuBij7PAhZYO9rvySRABDbOj68JMj0gV+YMeRvS96M6
         ba+P3MLAEnp46krG3aEP4pxIjDUSVQcb8PF1ekro4iQ3/THPbUDpOFM4IcD7bnSBGvj6
         fjNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JQ0+PpGv;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JQ0+PpGv;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAi011351
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
Subject: [PATCH 03/14] kconfig: show '?' prompt even if no help text is available
Date: Tue,  6 Feb 2018 09:34:43 +0900
Message-Id: <1517877294-4826-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778610656090?=
X-GMAIL-MSGID: =?utf-8?q?1591609778610656090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'make config', 'make oldconfig', etc. always receive '?' as a valid
input and show useful information even if no help text is available.

------------------------>8------------------------
foo (FOO) [N/y] (NEW) ?

There is no help available for this option.
Symbol: FOO [=n]
Type  : bool
Prompt: foo
  Defined at Kconfig:1
------------------------>8------------------------

However, '?' is not shown in the prompt if its help text is missing.
Let's show '?' all the time so that the prompt and the behavior match.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 90a76aa2..d346642 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -201,9 +201,7 @@ static int conf_sym(struct menu *menu)
 			printf("/m");
 		if (oldval != yes && sym_tristate_within_range(sym, yes))
 			printf("/y");
-		if (menu_has_help(menu))
-			printf("/?");
-		printf("] ");
+		printf("/?] ");
 		if (!conf_askvalue(sym, sym_get_string_value(sym)))
 			return 0;
 		strip(line);
@@ -305,10 +303,7 @@ static int conf_choice(struct menu *menu)
 			printf("[1]: 1\n");
 			goto conf_childs;
 		}
-		printf("[1-%d", cnt);
-		if (menu_has_help(menu))
-			printf("?");
-		printf("]: ");
+		printf("[1-%d?]: ", cnt);
 		switch (input_mode) {
 		case oldconfig:
 		case silentoldconfig:
-- 
2.7.4
