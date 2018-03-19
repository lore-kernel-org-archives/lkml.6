Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxNg4hoVqkCzgBNiUpyQYp5dCKYmFvghX6/Q3awoDcARJfwMsaO3T4dklzEd/49gQHiO+C
ARC-Seal: i=1; a=rsa-sha256; t=1521483537; cv=none;
        d=google.com; s=arc-20160816;
        b=CW0z9c9NBSoaOcpT1Dxivv5Vp8DkLaYk6fdIc5su1tQycD8nFtHAhlEKWDLlTPL+Yj
         52AamURAGJ+8R29fTEVnZQpFsEuVmN9jXlhpp4NXijpoGxr7/pJkbJdiLxNlVgUuyOfo
         UoSsHkHCtUuqwxvSljkZ05VnIdnRVp0U5avUml8w1P4sY04n2uPq/jY6ZbBOTEqOeFPm
         bzEkyg2BgY80y4uhRTCWxtZ8qEjq2zu10xneQhYE85rP2BkqpcNyDZj+crGtMMwRCAp1
         XXhoDeDqcPV0fIF68m+ruSgccT1XuelKM62PIBTTNMnobCPMz7V7LqnWDq+DfzcLukFi
         vyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9SGTOoLRnSIPJwmfXaWJ7CW0L1xZjm54AwdGTPOBDIo=;
        b=XkLjgUqFXC1uLrL8ywqHdO+DoxdwxyiwfJuM2gzAf1YVhLfB31YNHCnqtj2qPX86Cn
         bu3akvv+MrATi6yA0pV6lG4fSKLvpheqsJUNkVQwatXFM7jRebaqo3mrC04Plbih0l4+
         l+nXhJx6+Ry3EdDTqIz/TUBE2V71ZOKp21R5lfGGs2l3dA0yzXLKDHPuX/zHaqsErelM
         mALgNTjKVNBhWMwj99V61OSRcFiSb9vsZXVQhJoGDjXMlBzKHjzbznEXoDJM8FlCeyvR
         Gx6KCkSLgo6zxeX6r2v+JAr+1oV4dAFjSdc8hXGj0usOTmMUyk3M9qlYzco0gbPknEsO
         FH1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 005/241] staging: wilc1000: add check for kmalloc allocation failure.
Date: Mon, 19 Mar 2018 19:04:30 +0100
Message-Id: <20180319180751.404292822@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390769061869990?=
X-GMAIL-MSGID: =?utf-8?q?1595391122245992413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 6cc0c259d034c6ab48f4e12f505213988e73d380 ]

Add a sanity check that wid.val has been allocated, fixes a null
pointer deference on stamac when calling ether_add_copy.

Detected by CoverityScan, CID#1369537 ("Dereference null return value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/wilc1000/host_interface.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -1930,6 +1930,8 @@ static s32 Handle_Get_InActiveTime(struc
 	wid.type = WID_STR;
 	wid.size = ETH_ALEN;
 	wid.val = kmalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
 
 	stamac = wid.val;
 	memcpy(stamac, strHostIfStaInactiveT->mac, ETH_ALEN);
