Return-Path: <christophe.jaillet@wanadoo.fr>
X-Google-Smtp-Source: AB8JxZrF7OsLIUeYnuEeQTNHhl6X96UHMM07RWDz3Oqj88HdUCC7YIs2kK6AwtfgbhTf98bmziuG
ARC-Seal: i=1; a=rsa-sha256; t=1526106782; cv=none;
        d=google.com; s=arc-20160816;
        b=Fl/8/952CAEn0XybczBFqd3iL+Lbt5C/tTPymVULfzQoJ90yOnsyTRbQrnDOOn6yGX
         /5IiZVbj2oYIzLjhkranM5jw5KiRowRyWvBSH/gNbPqcMf3PVPvNsUP2YaVpjZxrSqox
         vWpOrHD9dMpxgPW3wS8+R6dq/di9Z4b+YJ8j69+piiAFbxh6r7cnIoih6OAn/uj0OEUO
         MPPFmhetCDQunA7ABMxxTJKk1xB0C7+pbJB/ZHTvoMx3UJAxNPwaLPqbF1jQ+dJmcY5z
         Hr+LjAhQjofIKxIjRRleiKgY1RH/HpemmzlG/Txp6XMxy9OGlpKoLWqSekZOCIxUgjJb
         2geA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=sZ2A21le/PzugzaJ7s14wen5myIWP233fyLroIzMy78=;
        b=MFZyia4ACk3o5ccPA9KP0/zyaMFd88C9aQ8jkoLt25Z1Q6+0J1nSLH/HjhWRZwnMq1
         zBSU2yJPYocSqjfAZ9SjSbOrI4TpyVYVgH1Lfl13w0IlsIcaU6DJDI0DeyCRw/I5j++o
         Tn5Axcp0bCZb9CT4pS9EcVLt8BSuVbQKSDrxD8WJmDeSdN5l3a0U+Ouzze1fVfqPtvNE
         xDEhyBMvUlpXu6yE4Q8xFws3jIMQwqmsYqTOcz65oEJ9XfmndDOOhC2a9mWDkeAQCUZ7
         nACDD1o8FTPXUBmmr7rFty6KarcXeXgg4ZK6HiQ9LBY5DOfwwuOS+5L2FiDAGWJ7OKpx
         qPPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.129 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.129 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 12 May 2018 08:33:01 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: oleg.drokin@intel.com,
	andreas.dilger@intel.com,
	jsimmons@infradead.org,
	gregkh@linuxfoundation.org,
	neilb@suse.com,
	aastha.gupta4104@gmail.com,
	santhameena13@gmail.com
Cc: lustre-devel@lists.lustre.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: lustre: Fix an error handling path in 'client_common_fill_super()'
Date: Sat, 12 May 2018 08:33:05 +0200
Message-Id: <20180512063305.7339-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600238944812579169?=
X-GMAIL-MSGID: =?utf-8?q?1600238944812579169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

According to error handling path before and after this one, we should go
to 'out_md_fid' here, instead of 'out_md', if 'obd_connect()' fails.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
---
The last goto 'out_lock_cn_cb' looks spurious but is correct.
In case of error, 'd_make_root()' performs a 'iput()', so skipping it in
the error handling path lokks fine to me.
---
 drivers/staging/lustre/lustre/llite/llite_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index 60dbe888e336..83eb2da2c9ad 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -400,11 +400,11 @@ static int client_common_fill_super(struct super_block *sb, char *md, char *dt)
 		LCONSOLE_ERROR_MSG(0x150,
 				   "An OST (dt %s) is performing recovery, of which this client is not a part.  Please wait for recovery to complete, abort, or time out.\n",
 				   dt);
-		goto out_md;
+		goto out_md_fid;
 	} else if (err) {
 		CERROR("%s: Cannot connect to %s: rc = %d\n",
 		       sbi->ll_dt_exp->exp_obd->obd_name, dt, err);
-		goto out_md;
+		goto out_md_fid;
 	}
 
 	sbi->ll_dt_exp->exp_connect_data = *data;
-- 
2.17.0
