Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuPp2xWuccEbOq7n5rxVAPlG5kurb8mOYlA7jXwue6S15NZ1kX6kLQVglb+G4FtU4Khc0MU
ARC-Seal: i=1; a=rsa-sha256; t=1519411051; cv=none;
        d=google.com; s=arc-20160816;
        b=qcGzKN89NtxPz93Zosb9hodStq+eIwIH0vvqLLGlTzDHRuecH+kiZWpdpJv6hJ+8kM
         jaaHHC/bsQaBs5zo7LdNggCDc1n40MHbcd+8NeKrNrhvZ7R5/R3pzyCxomvdz5biLn8k
         CwkNWo6mLU3+CKwdz+ajSUzPAP8pGk/QKbvzAoDHa4PSbpEi2lch1P54kPpWMoYLm9uP
         rD2yFA1rMqCoLAy6Mrbnz/oIJsLGuStlU4axzzvf89orAVQ4BmQq+mDpKboSEGrb9D0x
         KPJyBYG4GqrwvWUfL/suiNmeWJ5/AKsFVkaOsCJBGykrXdj4AyZAtTK6BRHy472xcrNu
         ypag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LqLCFjZo1HKO+JvD90GzcEPQVeZhxU9/QJvvrrCXFP0=;
        b=U75mcGQCF3ZfN7INUXjnBV71bgJCnbxWbxk/+q29D8yVvLD+zbleaxzlrHG7DZiCNi
         tNESSRlZHruDCrohG2lEyrhXvYDygGrCsCbvlM6V176JuaIsDSuatRVKeFyVHJZdH80M
         NRHcV0QqwgniWuYqH3kGrjBmL9jN/xgV/kOQVrBtr3S9PHlNMWEwcPR7xinW0B/eRGZT
         uuOmzXJPsVxoKi8k7cydW81SK0nalh8ER91fzj9aF1g215DIvD/HR7uIKuVBOQ1xIpBZ
         DYGgNM52T/oRfw0epKvUtmILO27Ra6ZABBXarIxJxLU47E07nUu7Vo3dA6Dw55FvwGf7
         SrwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 103/193] driver-core: use dev argument in dev_dbg_ratelimited stub
Date: Fri, 23 Feb 2018 19:25:36 +0100
Message-Id: <20180223170342.087780611@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217963253722803?=
X-GMAIL-MSGID: =?utf-8?q?1593217963253722803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1f62ff34a90471d1b735bac2c79e894afc7c59bc upstream.

dev_dbg_ratelimited() is a macro that ignores its first argument when DEBUG is
not set, which can lead to unused variable warnings:

ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_cqe_sdq_handle':
ethernet/mellanox/mlxsw/pci.c:646:18: warning: unused variable 'pdev' [-Wunused-variable]
ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_cqe_rdq_handle':
ethernet/mellanox/mlxsw/pci.c:671:18: warning: unused variable 'pdev' [-Wunused-variable]

The macro already ensures that all its other arguments are silently
ignored by the compiler without triggering a warning, through the
use of the no_printk() macro, but the dev argument is not passed into
that.

This changes the definition to use the same trick as no_printk() with
an if(0) that leads the compiler to not evaluate the side-effects but
still see that 'dev' might not be unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Fixes: 6f586e663e3b ("driver-core: Shut up dev_dbg_reatelimited() without DEBUG")
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1272,8 +1272,11 @@ do {									\
 		dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__);	\
 } while (0)
 #else
-#define dev_dbg_ratelimited(dev, fmt, ...)			\
-	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+do {									\
+	if (0)								\
+		dev_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__);	\
+} while (0)
 #endif
 
 #ifdef VERBOSE_DEBUG
