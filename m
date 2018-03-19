Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtTxdKkHXDR/FvFdA9UJBsquhAlm3DrQ5RoQpJk25DMCGhz6rXEqHi7aGJVoP6cPKNA/Pq4
ARC-Seal: i=1; a=rsa-sha256; t=1521483417; cv=none;
        d=google.com; s=arc-20160816;
        b=I41KzVfjCCdcL74fS0cDfdRzpebk4x/gB3A/rN465Mevd8lCeH1MbRvIP/wKdbPxqb
         mm/jK7sYlx08LCVMcUcCdb+d9n9sm/cmxEXnudwQFOLHBEQzbflyKKUqFFEjjqn41hhn
         ax1VHJxvK6351+Z9RhZMheM1NIbuA7biPItTuT/AbNYy9i2IAYnbOYgQzTADxEVRiqmr
         bFRNsLVk4WKH7wUi7PTNF0VeN/2bRXb5xOOgrls9m1ElFSewdH4+jfvI4PeWtMB9xTAV
         wymXnFp8K7TjlsZiRkgie3qjWYe/nY3RJhiHxx2vaBHy1AVGmVBcsZbhbPaEENOHv+Pe
         ueuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DdBVoic6yR7xEj2GrNDrixUl5JsghFoMcRq0p9gbTL8=;
        b=Yy7QsuVJ+1pUdkp5rMC4d+5X6V587/6CLAcN0JxbmrxeujvZ11OySi4tB5qALnm/vp
         4GvLQzywI/nD9rJ1Evom3pwWh5rpFWyP5yOZB3/rhSlu481VARi0fFj3ZXtsLztIUcax
         RFvBtUH6pIwxBGL1fJjLuCYEwpvjgfhbKkZsqZtGKCIKG46EfFDNVDVotUY1lDQIeGlw
         AHP+5A27rUx5ZbaB0k39BXpC+79HGE+X1FEWny4YtVRehU0tHS9xW6ITNxKkOVmW3qVm
         fkMlZYr3jLBrNsSE/0s5ObMJlpEIH3J6i34+AF5H12cWlKjHghGErxgK5WIdmOD5JCh3
         fUfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 109/134] ima: relax requiring a file signature for new files with zero length
Date: Mon, 19 Mar 2018 19:06:32 +0100
Message-Id: <20180319171905.020768938@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390639959423215?=
X-GMAIL-MSGID: =?utf-8?q?1595390995909702379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mimi Zohar <zohar@linux.vnet.ibm.com>


[ Upstream commit b7e27bc1d42e8e0cc58b602b529c25cd0071b336 ]

Custom policies can require file signatures based on LSM labels.  These
files are normally created and only afterwards labeled, requiring them
to be signed.

Instead of requiring file signatures based on LSM labels, entire
filesystems could require file signatures.  In this case, we need the
ability of writing new files without requiring file signatures.

The definition of a "new" file was originally defined as any file with
a length of zero.  Subsequent patches redefined a "new" file to be based
on the FILE_CREATE open flag.  By combining the open flag with a file
size of zero, this patch relaxes the file signature requirement.

Fixes: 1ac202e978e1 ima: accept previously set IMA_NEW_FILE
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/ima/ima_appraise.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -206,7 +206,8 @@ int ima_appraise_measurement(int func, s
 		if (opened & FILE_CREATED)
 			iint->flags |= IMA_NEW_FILE;
 		if ((iint->flags & IMA_NEW_FILE) &&
-		    !(iint->flags & IMA_DIGSIG_REQUIRED))
+		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
+		     (inode->i_size == 0)))
 			status = INTEGRITY_PASS;
 		goto out;
 	}
