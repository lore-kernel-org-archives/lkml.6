Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELsUsMnGBRcZ9Zl8jeOx2b2UPsLrr/7IHNv2PvlA/4DY39w+Tn2zK+tMencUO4J8yIr+rAvj
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=KQ+6VATaEfNjb5oFxUelFNXMX/6SnCWr1MiGNH19c0+yrlgt6w08Mk5b+qLTTKcNMS
         XJHROjJVzkHRvZ5Td12aEsbrn67rrht1MG1qmnYjhACP5MCRQf6/qO0lhCdsqHDZkNtQ
         34uzDhwEqlKEjMivXqi8Yi1LEMZ9oFhqptFSoc8tgfBBVdfmo3zMihMiQprJwuMVcDcT
         Tb8Ig/oyBBe/okh5a6U4pUI2Nr2YZQN8mtapXuLq9YCxOeOGXHGjcFaIKEG9B0XAUEoQ
         ysJbH8kOFZKA6yU3s36Caaq3121Q3nt1bixWhDe6idTRdKfxNzKIiWQsm9fPZXVrOmGw
         QJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=3YSzDtX7AAyzV3555aHdl8YmRdjyPFtREyhq2EffcVw=;
        b=M1FgBFvZ2O97saDXAyoZz2fP7++IbZhxv6UxP4goyhTHfPUlAqarGXod43oMxSWEYN
         gv3Ic/j/tERkExCNdQzNqymUY+Ajjav0MMh9fGSpfUYAr6kFnfGv+N/znPu8SCf9mK/E
         +0tpoQQjwMXM9Jvma1wODcH3pf9656B7USHwaWrKTIbnF3c5tTRSOIOITZjxZlbIlcNa
         rI426bunke+IolA/tZ4USW+CdVKDRMhUp03WQXXKSJCH1BVX+/044qJFG6ZFer0Tsf61
         cxYCh/qSEu0jU/aonPNkSmAXAAKrQr78F8LggNHQwmBbqibtB0rsNWRzLgThYzIn2i07
         4bHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=WO0pecUg;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=WO0pecUg;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLo011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/21] kconfig: remove string expansion in file_lookup()
Date: Tue, 27 Mar 2018 14:29:19 +0900
Message-Id: <1522128575-5326-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538242865703?=
X-GMAIL-MSGID: =?utf-8?q?1596067538242865703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are two callers of file_lookup().

[1] zconf_initscan()
    This is used to open the first Kconfig.  However, it cannot
    contain environments in the file path because zconf_fopen() is
    called before file_lookup().  By swapping the call order,
    KBUILD_KCONFIG would be able to contain environments, but I do
    not see practical benefits to support it.

[2] zconf_nextfile()
    This is used to open the next file from 'source' statement like
        source "arch/$SRCARCH/Kconfig"
    but this has already been expanded in the lexer phase.

So, file_lookup() does not need to expand the given path.

By the way, file_lookup() was already buggy; it expanded a given path,
but it used the path before expansion for look-up:
        if (!strcmp(name, file->name)) {

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Simplify the patch.  Just remove text expansion.

 scripts/kconfig/util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
index 136e497..3d27c49 100644
--- a/scripts/kconfig/util.c
+++ b/scripts/kconfig/util.c
@@ -58,18 +58,16 @@ char *expand_string_value(const char *in)
 struct file *file_lookup(const char *name)
 {
 	struct file *file;
-	char *file_name = expand_string_value(name);
 
 	for (file = file_list; file; file = file->next) {
 		if (!strcmp(name, file->name)) {
-			free(file_name);
 			return file;
 		}
 	}
 
 	file = xmalloc(sizeof(*file));
 	memset(file, 0, sizeof(*file));
-	file->name = file_name;
+	file->name = xstrdup(name);
 	file->next = file_list;
 	file_list = file;
 	return file;
-- 
2.7.4
