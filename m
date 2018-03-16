Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELulm543L6bH18Cn/3wYfBGh4y1ZQuGwV38IEJNMqwzw/iukXIGOEuuf9GY1+EPlsGUBULbN
ARC-Seal: i=1; a=rsa-sha256; t=1521214219; cv=none;
        d=google.com; s=arc-20160816;
        b=EyIC2mvNygso+dfE4qSl0vXA3Vo8Ab+YhR44prW5OY4svstMwQljkwxqXYjN0eVgib
         wns1q9QzjvFqcJL0YG0T/nWgqRCnVHxSkMe44Y0f+7W3NOD/eFXyvNWoQIlIwx/5i8fm
         Vc0HNIUQXZBvNcXfKVIpAOX93UZzp5XNTD8iHmCtqJvevbPgwEpuaDDfUk9+heAlKcwC
         YLcfmLqqcm+NAjMkbyFem17XmT6eIrMp53ypGzXCRQcRX1/+Z2pkeRIyDkNjXRP53mAX
         RBhFzfkoCUck3/jzpCh0djtaPh29DUPIFk+ys5FAJS/oNUxkZupivAAfiukyFdvt555u
         V3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YQAR7MU8EA3kzQnU3kH99+9iPiBzVxr2+DMdQ96zfFg=;
        b=pcTxtYPP6utLaBp7vQ+sNp3qK1i2472TjUnAosfVr40JCcdoDFMM9XlAx983kRHT9M
         Sp5BAtmuXIAMtb0ng6ENczsgrnQgT/6BxD2EF6Yo0UARx2GMDCgEFXWCnHmEoj5Utwyh
         GQw9rH9M+u8dkLBEc+LISFvHeb60xxYCnq04qptxryT5Jqj1hwfKJYaAHPaeJwzs+h1F
         ZZpDMQ96kKXbg3bPPfHjkyqwmJgPIhdzBSEJc26mUNXLzp3GGj6H9nq3Rrn6GLqqa9Ui
         gZ2YbuKdzVEc3BK3UQPvxtX5zqpwfORDxP6Fm6WIZVJ/CugiCT3umId4j1UkIz5AWyud
         RyOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 18/86] MIPS: ath25: Check for kzalloc allocation failure
Date: Fri, 16 Mar 2018 16:22:41 +0100
Message-Id: <20180316152318.571317500@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108599350842793?=
X-GMAIL-MSGID: =?utf-8?q?1595108721622216703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
