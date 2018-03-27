Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+vUo10VoEIy++mW7UYovnqgmUuDj+bAOIUIpX8qepV4IGgDd8AMGut8Gc+VPuFaq2Jrgjq
ARC-Seal: i=1; a=rsa-sha256; t=1522168720; cv=none;
        d=google.com; s=arc-20160816;
        b=H36K9+6Bw4cuhI8WOMdKO0llWTb9j9vt9m2HuHnWadD9yOkaUwI+bJCXSzSGUrcbVf
         2oEOXBw8L4JWlWShBkwgmWyU8L2fQARiNVt/C/ZZa2ItJQVs1jEq5Ykb/zwYfUjZeyqK
         rukOmmJguP7bZZBPEoWJNzNmhvXwlM2yjdpzHrSloq/OkBlImjvIeWu6gpeEVTVrWlN5
         VpJCBHqccq7ePJU+wM/uDwJwOkkq9MPDebJk4CGMvvGrour2RVZ8mRiH+Q3v3T7X+oR0
         lBTTAb0qhWncfQ5ma/xj1Mv8k4xrz4Oz8ZUFSRkxdnK5BYa1y5+5iWC0LgMDPrY5y8QU
         eKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fq7ho4mvMrTmcqIoD7rts3hk/mbYXRLUO0LzkNcx9IE=;
        b=B83f4XJpOY0VeHsagnaUYKTijut+j9nVfGOhqY55uGepUVHBIRU0LhZLRRt2WmUTMf
         Biom+bnhiVmUQrQIA6HcNlHjmgSNdgA3+lDDTYGKI72uexi8SvVRJBi/N+8/0UQhTzmt
         pe4oaWUXPiqKMmfom6yI1rP7oCAkgDXyvtGb63QeY9yRhG2JIHyWJN/DIaxKwuBb00Pf
         a42v/HhtPw16/TGgJQP36ZY3lwF5osZa91+wHToN7FSddraLeMiL1wPWhRQSfQkDvuoH
         cv7lbZbSHZvDSuko5Ljuuy8ZvyxQRgKI07P97T+7+zW0lUrfKi/UdSAsKYwYKxs7vGaE
         fZag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peng Tao <bergwolf@gmail.com>,
	Oleg Drokin <oleg.drokin@intel.com>,
	James Simmons <jsimmons@infradead.org>,
	Nadav Amit <namit@vmware.com>,
	Andreas Dilger <andreas.dilger@intel.com>
Subject: [PATCH 4.14 095/101] staging: lustre: ptlrpc: kfree used instead of kvfree
Date: Tue, 27 Mar 2018 18:28:07 +0200
Message-Id: <20180327162755.855696211@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109071523353050?=
X-GMAIL-MSGID: =?utf-8?q?1596109588553047509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit c3eec59659cf25916647d2178c541302bb4822ad upstream.

rq_reqbuf is allocated using kvmalloc() but released in one occasion
using kfree() instead of kvfree().

The issue was found using grep based on a similar bug.

Fixes: d7e09d0397e8 ("add Lustre file system client support")
Fixes: ee0ec1946ec2 ("lustre: ptlrpc: Replace uses of OBD_{ALLOC,FREE}_LARGE")

Cc: Peng Tao <bergwolf@gmail.com>
Cc: Oleg Drokin <oleg.drokin@intel.com>
Cc: James Simmons <jsimmons@infradead.org>

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/lustre/lustre/ptlrpc/sec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/ptlrpc/sec.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec.c
@@ -847,7 +847,7 @@ void sptlrpc_request_out_callback(struct
 	if (req->rq_pool || !req->rq_reqbuf)
 		return;
 
-	kfree(req->rq_reqbuf);
+	kvfree(req->rq_reqbuf);
 	req->rq_reqbuf = NULL;
 	req->rq_reqbuf_len = 0;
 }
