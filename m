Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSgddMKaWrrzGfxfY2czYfRAytiy6YMAtnCERdFpjfD7KSJo3tOi0ASRs6MlSvJLE0pH/D
ARC-Seal: i=1; a=rsa-sha256; t=1520955524; cv=none;
        d=google.com; s=arc-20160816;
        b=tVXCdraQKdSmer3fkztjY4ULjVFo8xueOoD7JjnDQx35MJnzo0ahQrtwER3H95Q9bQ
         KUSIrZZ2NPdOkrOetk6QBaBza0T0Ui7ZMy4mlEnxnUuZYf1jhEAV3oYnv/+QNwEuVIXX
         B4u61SQBnM/+hncRdqAbKkig6SD1BLX2GDpaGaI9cv6qrfDh4JdIdq0QavSImKvNcnup
         ++WSXbyQmxO+Ybg57fGIvfs5HZDim34IoSzXLbmKtHzEic72yGY9x3umOfXdkukL+zBV
         4QA61nkcI8sPAXdBi9XtNc9/6GzOVWoDGk2UF+glAEP1DBovHxjaD9Ve07K4/yUA0pDn
         mwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fm6AodDvrgzLgXBYtUU5uHUdRl6LqCpCHN7ZgQUroV0=;
        b=dojuJimMCPyuNJics2hPS+WoqBY+xxldBUQskeus3/pE+zt/WqkgUEWfh2LO9Sm/1A
         NB1WkCQfm6A6j3/b/ukSZC5PaN195ES8flRMW18My54imst4HYXEHndkXIolhmNMxyas
         z7/vns4u/3hLhkRaXCHDDhRgf5siH0256HPg8TgbYG54soMeC9yg4LzUTm86tYBha9Iq
         nXjMAFWATqdw09LBNDrSs8JAsNGfduboIf4NI0ymy/jei8TUivNPX5p0iQMwaO2kEe+P
         B3OpDiE16lTQ3Q8qhHNTa8DrXBKwcNVHX2yZ8X7wAIUOrcyMha0A1JHgRK+3ub+jWYig
         1YvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 079/140] MIPS: ath25: Check for kzalloc allocation failure
Date: Tue, 13 Mar 2018 16:24:42 +0100
Message-Id: <20180313152503.444009904@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836869836230255?=
X-GMAIL-MSGID: =?utf-8?q?1594837459806456940?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 1b22b4b28fd5fbc51855219e3238b3ab81da8466 upstream.

Currently there is no null check on a failed allocation of board_data,
and hence a null pointer dereference will occurr. Fix this by checking
for the out of memory null pointer.

Fixes: a7473717483e ("MIPS: ath25: add board configuration detection")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.19+
Patchwork: https://patchwork.linux-mips.org/patch/18657/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath25/board.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -135,6 +135,8 @@ int __init ath25_find_config(phys_addr_t
 	}
 
 	board_data = kzalloc(BOARD_CONFIG_BUFSZ, GFP_KERNEL);
+	if (!board_data)
+		goto error;
 	ath25_board.config = (struct ath25_boarddata *)board_data;
 	memcpy_fromio(board_data, bcfg, 0x100);
 	if (broken_boarddata) {
