Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227JKPZB6/LJhYENUNGsLPZge2xD1WO3GsbeLGr1hkeXOY7jQiGVXMmxPB6MKYu0dSQT43SD
ARC-Seal: i=1; a=rsa-sha256; t=1519217767; cv=none;
        d=google.com; s=arc-20160816;
        b=KAQQHyuoe31Gcqfa2WtEQKiBiloNNfbxsdye4WiCG1afx2HofFFT1D7z1fbuD/Lwks
         1KFWDS0AIa4r6SDK/e8oJGG6qAB9Ilzeric2f4D1TQ7yzNbMW1cCdcOSW2LJkpzLbL6d
         VeTBPR0mOA9XR7juENwP7fyvOXwfLytTiZ4Tk9wq7LaE8s1y8u7U6z7py70Uz/s2Yuf3
         ijs7NztMHCYd+3jYwFMH8+BpOwdTwbvxlh9+eyEQga1BtlLeu5jp5i44B36cHVCmHqG6
         plXRUtxZyRkgjZPZls9IHMyqxwCgh5ljXda25L55T83xKXuGmSepGqnaPgbJ5J/OHIXn
         hBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B5hPP0Pmfa2F6JpWgTDhwF4dBhZH95B/InLJDuLObyo=;
        b=FvZobAQY6fGXeYz8cDUrKpl2vWRfSvbXdJ0+37yLATwIa3Ca5xX83xXbqLxcfnjo5T
         Lbd+b/m2MKKttxIj2VaFK2ZppWxfM1Nl5GEEewHtPszMi6bCPnF0rKrLslYvfU8NAJoM
         VXwr55AbNboFFDqXitHzI3J2BkaIdzZQB6zUeDHpBA+noM7Vfy58JEWJlauquRrjJp6A
         NJdEnT8x6obhKPm1cR++HaZuXUePNdXyIjCROSayxoyAP3gwj4Xs26LYv+vqEHVZIzr7
         MGGi927NS3LZvZBAJpEg9Ru3skuF3s3dIMSzoINAu+uNTCpwuaa0aKtXUgy7vS5kLYKF
         RypQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 11/77] mm: Fix memory size alignment in devm_memremap_pages_release()
Date: Wed, 21 Feb 2018 13:48:20 +0100
Message-Id: <20180221124432.631219550@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015289662337043?=
X-GMAIL-MSGID: =?utf-8?q?1593015289662337043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan H. Schönherr <jschoenh@amazon.de>

commit 10a0cd6e4932b5078215b1ec2c896597eec0eff9 upstream.

The functions devm_memremap_pages() and devm_memremap_pages_release() use
different ways to calculate the section-aligned amount of memory. The
latter function may use an incorrect size if the memory region is small
but straddles a section border.

Use the same code for both.

Cc: <stable@vger.kernel.org>
Fixes: 5f29a77cd957 ("mm: fix mixed zone detection in devm_memremap_pages")
Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/memremap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -245,7 +245,8 @@ static void devm_memremap_pages_release(
 
 	/* pages are dead and unused, undo the arch mapping */
 	align_start = res->start & ~(SECTION_SIZE - 1);
-	align_size = ALIGN(resource_size(res), SECTION_SIZE);
+	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
+		- align_start;
 
 	lock_device_hotplug();
 	mem_hotplug_begin();
