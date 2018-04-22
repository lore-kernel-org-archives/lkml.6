Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+kmi2CE7iUcsrLvj+Xwi8FRHcIV0vnVpnjjt06AEHgGqB1nH/pqfipHulrLQ0Kqau0fUIn
ARC-Seal: i=1; a=rsa-sha256; t=1524406834; cv=none;
        d=google.com; s=arc-20160816;
        b=tbAf6KlEbmARWUf6/BY/O4Tni/WB7o/VhOZPk4BrSRUpuUm54EgpnxRtB+lxICRG3+
         KOGrfvzNrUJXukaur+gNSFLnhH46HknHWju4C37HN1Y87HQsf+Fn3ZLZVc/9FM0jABUR
         iYyANpnVGTIfRgRmIwTfTjp5FiXqQInstRECScy+nN6q5RL0luWqEYdkmW3owMR4fX8C
         Lhd8M+R8QZjKi9LuT+vtZNsRC1mshqsqSWtvdur5jwXQ6Zsc8GFjG5FXtULVESWlMyJo
         7KZcmSxZZdkYdNJFnRbZcQGKRAHXC7O3aa+chqlQQYXPEd3pHqEN6Q1eCnDLpUKWUwFp
         jv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Xrzo83wJXtuIxROdn1YjwMtTBZv98nVdkekLvWUCudg=;
        b=QqBm+V0x10IKoFUoThgtPG0FqWhjYbWkbpRk5qdIEysd9F4B8CBJvvc/zyHABDHgNM
         kKE3bBPVf3zVZNDo1IPkNg1DzSBugQk9D4UosIadxP/rrMVSQYWLchCSvi/AedKxrpyq
         3OfFbRgKJGH07otg28+CcnuvE4bR0mkrAtrJlDBOS+OPE/tilUaPG8TCLKq/GK/kTmk8
         nW0LKb28moxcym1UVcCC8bFBhbbJ98zOI8m3Zb7B8mfY74ItzhxI5magnyzML+wS5Atk
         iKsczteezdlwiwaAzII0e/gJoSDrClCFb1Uzvg6rGpPrDISfp0/Dge6Fn7CfQLFSHoYO
         qZWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3.18 05/52] s390/ipl: ensure loadparm valid flag is set
Date: Sun, 22 Apr 2018 15:53:38 +0200
Message-Id: <20180422135315.479414322@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456107565635431?=
X-GMAIL-MSGID: =?utf-8?q?1598456421190112331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit 15deb080a6087b73089139569558965750e69d67 upstream.

When loadparm is set in reipl parm block, the kernel should also set
DIAG308_FLAGS_LP_VALID flag.

This fixes loadparm ignoring during z/VM fcp -> ccw reipl and kvm direct
boot -> ccw reipl.

Cc: <stable@vger.kernel.org>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/ipl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -808,6 +808,7 @@ static ssize_t reipl_generic_loadparm_st
 	/* copy and convert to ebcdic */
 	memcpy(ipb->hdr.loadparm, buf, lp_len);
 	ASCEBC(ipb->hdr.loadparm, LOADPARM_LEN);
+	ipb->hdr.flags |= DIAG308_FLAGS_LP_VALID;
 	return len;
 }
 
