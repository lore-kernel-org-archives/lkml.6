Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/MpHhMk9ylWgmqDvkpr4KEHJVdAw7z7ea+44SiNb2GtXuXosb9xRbmj8XtYdj/dKTe8/H5
ARC-Seal: i=1; a=rsa-sha256; t=1523021953; cv=none;
        d=google.com; s=arc-20160816;
        b=o6oZyFEJfaGo4G3rGuM3QTwW3BdePFZLGmxSXfue84PDmwa0K0olNp5k8xBEPqVxTf
         XqeKkB54xN36p6QdM2os2jFvDdCKRlxn4j0GmHHHV0auchZG+OTGW0aj9GkgrKgSIMtM
         071/Osyp8OKh6g2m54D22Y40VCC2SseH9Dg4ECkwkzQN4b35xivLfIAx09FoNhWR7Elq
         Kx7Iq7emu/jfgyw4dJRCB4vms7B+/DMt0znx59lDHqXcfhlV7fCp5qBDx+Qg7SwO3DI3
         KcQ6jEKHVWK5PQmAbXcRO5VbxTYaDTCtWLARnEndepN7UEGQRqtE0uUaPcMW3aWt7E+C
         zL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FOPixltBH659ldpt61albG65uQnQzTKBY5mUE5TuKsk=;
        b=CbCHUib2PQBUbIiq461qP0FjTpZryiIG16GHzSNYB/v/AT+vt8MEqBJOfL4MqMhyrr
         97kfQkHqCQAma85Cw63j/awY30PPQ2/C9O5X9w7wFQM/0aWS1/ukByMJQ3/IlJAffeb1
         K44gHqc9kMFSZj/oQHcoG8G2JDdCoFCjfAFHRojrTVgFWwCvFLNZAq3N2BIBPkw/6V9l
         +Nl++bQWnAUjA6KDXyYEwJTucXxmwaGhyD0aj/XVANwCQ0yvkSAXsrC0aQJvWXbiYlQb
         Tjjjx8Y9Vu5mYsJkaOBATVzGbaAMWMhEMip6h6sXTE1lXXNsGdeTZMBYjxzKkKpmqgoh
         wedA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 46/67] crypto: lrw - Free rctx->ext with kzfree
Date: Fri,  6 Apr 2018 15:24:16 +0200
Message-Id: <20180406084347.373431668@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004267731189000?=
X-GMAIL-MSGID: =?utf-8?q?1597004267731189000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 8c9bdab21289c211ca1ca6a5f9b7537b4a600a02 upstream.

The buffer rctx->ext contains potentially sensitive data and should
be freed with kzfree.

Cc: <stable@vger.kernel.org>
Fixes: 700cb3f5fe75 ("crypto: lrw - Convert to skcipher")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/lrw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/lrw.c
+++ b/crypto/lrw.c
@@ -313,7 +313,7 @@ static void exit_crypt(struct skcipher_r
 	rctx->left = 0;
 
 	if (rctx->ext)
-		kfree(rctx->ext);
+		kzfree(rctx->ext);
 }
 
 static int do_encrypt(struct skcipher_request *req, int err)
