Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/D24IYZSZ7OPYKToGtlvQ69Up53T2DIX1iQUoFGhLga11pN+7ZWjDZxGwdVGX05P7jQpDb
ARC-Seal: i=1; a=rsa-sha256; t=1524405419; cv=none;
        d=google.com; s=arc-20160816;
        b=Xa4d61jN63hFEgqoadDfcIUgjjojx5o1V8KVF1N/kTa5W5rHFexpawoczLhovqRu/M
         4GwfC12snc8D1Ah9zDvVmLoJ/MKLKmo/Fs42CfaIdMf9nifZan/Q/xaVVMcRULqn2EtD
         qfR/fMijV7SItunPb6AYxCqnR3LHGG+9yvpzqrMK+V2TsVZvLKylf0ArxaA+CMjltG5A
         V5iDrQpsdUAlrRMxysw24YtZ4p1Yt8pjDgQS8ZrJU8sLpJEyWfWG9lyUkoSOhuy+Ckbt
         PSwRafsL/KWC+9Fj0jzzSfliSpER3f/t2wnfjmICSJgub2jhsbj3ZpLI0j+u2Prz8QVo
         MC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6jgVBpImNg0eIp8i1PB/v7XxBBuItkg8Jep67odsNnU=;
        b=I4+WgcHoRsMNXvb43SOm1fk/Lp/BoF9HqAU4wSfEPbQ/EjlAAyjHAtJT0L7hXqi3u9
         3KUc/Kt4+1L3m4oavc+ReYMVWHTZrzlEhT7OnHeEWxabXITNNtoKz3hf+ax1DZVKeFrA
         CWgHaXQVVf6uExwEBafYN8jv19qW+SVCXt2FmfgSOVsFF1Ctrmcoh0UPeHeaKA66Ocv2
         /80uLV6KamAqLiRSXjhewQin+xTJNHUidweAq4hT7OxTpcBNkGpqXLBaDNC7tOskCt40
         kCNfpeMzCLXlnvoTI8nC6JSkV0aLaAvjdnfIoF9T93N0Y8yE8tWBOhoTEpULy90Ms3jt
         Vq1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
	Stewart Smith <stewart@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 060/196] powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
Date: Sun, 22 Apr 2018 15:51:20 +0200
Message-Id: <20180422135107.330955155@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454937101435263?=
X-GMAIL-MSGID: =?utf-8?q?1598454937101435263?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 741de617661794246f84a21a02fc5e327bffc9ad upstream.

opal_nvram_write currently just assumes success if it encounters an
error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
on other errors instead.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -59,6 +59,10 @@ static ssize_t opal_nvram_write(char *bu
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 	}
+
+	if (rc)
+		return -EIO;
+
 	*index += count;
 	return count;
 }
