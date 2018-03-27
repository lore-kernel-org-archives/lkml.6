Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/q5VmdAef7R8LFAtgzrnr+SivsQFFbwFrm1i+G/4FnMmeXVrbxbg6Ss05dFYJIgSCZzaoP
ARC-Seal: i=1; a=rsa-sha256; t=1522168382; cv=none;
        d=google.com; s=arc-20160816;
        b=HjEcSilZThJSCfztiL40QmxNxyIm6KCVO0kfVZ5hIToUpBA/EE2ERgV9LziH/Zxs2p
         8iqLM2w05v1SsCIz3obYjbGb9HkgLSpiE+n+ZJx2s3Zw353dLkUHnAc7MNU5TSMGsi0C
         iSBGLL/54at+uYLznfdfxt3jNhXmVPL+aUAaUsfqTLw/PwxAQnHeetZ0m1cV6MfaJ40h
         htrrHJ5EHkTXa3/HrOxytPtexYsi0To4iWvZpdl8tO2es6mbz+ydgz99QGIqsuVjr0Hc
         tnNdur4afzE7KBZielHZpwq5617kEld9oPf7wxCK9gvtVV/YLzENM7Oz3bguM4u8PSDc
         pIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dNI2wgrMRyS5kKdCvRFagt9OIYYjdarg/U6zLVbXF10=;
        b=bU3bpSzovCuSta1M99JTsB2FIO3BcrcFPOy0IYRmifIpDItLS+d5yNNYMfEtaTJ7d4
         b7ANAZE0CEjzGJfPPWzG2x+YwQzMqX+cc3j2BEZ9S5ty54bSxNkx16Y/KUfd1BzlMPhR
         sR5kzQr05gCWBTSs4645NzudVRAGdOp9iIte6QqwTkkB/TgVkcfODHtW5uYCbwxdkPue
         9MzPHjCPBOHUdOzbNJym8uDm8uTusHV6F5SspZcdHJipP50iPGZNQfVjU+S2nv0HKf3/
         jCOpnfj+NiEhy24FkhLdU6lv8x1/ohSKLhdL5JzrIghOuazs8mHrFuPyLsPNOaXEW4QA
         E7VQ==
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
Subject: [PATCH 4.9 59/67] staging: lustre: ptlrpc: kfree used instead of kvfree
Date: Tue, 27 Mar 2018 18:27:51 +0200
Message-Id: <20180327162730.846541999@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109071523353050?=
X-GMAIL-MSGID: =?utf-8?q?1596109233559406083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -838,7 +838,7 @@ void sptlrpc_request_out_callback(struct
 	if (req->rq_pool || !req->rq_reqbuf)
 		return;
 
-	kfree(req->rq_reqbuf);
+	kvfree(req->rq_reqbuf);
 	req->rq_reqbuf = NULL;
 	req->rq_reqbuf_len = 0;
 }
