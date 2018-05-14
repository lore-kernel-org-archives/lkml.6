Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqnKyd9BlYwkn5XHxIiTvXnv/7p8UirY6oMs9rGS0Bwe9h7Vtga3xQG3PEOczlqbaL6PABB
ARC-Seal: i=1; a=rsa-sha256; t=1526280701; cv=none;
        d=google.com; s=arc-20160816;
        b=Zw9DceWZTU6EIYvBAnrlwSfoo8aY9XrLkV2WYc3pV0BWx688wW04n3q0x/CmRuoKQA
         nP5IWFbELHEdUqIpqUWaiWR5sg/sag4oPrLujQtYeRQimPdwMyGPMIaR1vCpi/1kjWrH
         r6+OBxotvNjq0cMwkmn5+wR6ttg0KMvoWyJ9tFS4Rkn/tnYZ94X1OLCQre5vyVRiXTev
         80kgosWJq9hQR/s1KKVmvkMTApUZhwWDqD8hEdrLylUBQt19ru+Qk1F6HQlQUAPhbact
         nKLfDmFS/2ebTvuwm9O/RFuGH2jUeFVrYy/cQKcFPbc7A0Q1TXN0GiFKgBh/VXIOMJmi
         1hTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FmJX+tzWI5hox0QQQgRHLzfsJ4WGv4JSKpqsv/apHUs=;
        b=Y13NvsxnkeHLkQP0kflOZ1qRUjhpOMME20iGmmmnCLf7AsDNQ8xUUGO+Q/g9kvGABI
         9UDJy6VYHoCNa2+d5nRaK3A14yciz0OjUBaaN9HjsnJnAiGT2SITsDrDa8ZU4Gt0lVCY
         hG9JUphuyP0C+mUcLuMTfZqVul82SY9rERXQcf0QmuXmCdSghZhZ9f9VrBFIbqeUrWOs
         bo65tMoDWYt9kj2Kmz+PjxqirlyHR+KI3nmILl0nzH4HXHeqzFebDCd87IJlVu04npBc
         3bghWPRLE5F5ee3MuoXd/dpSW70+7YGTqCXPxf4kRv4FxniAeGudqiNUAzjSzS4kXBI7
         wjXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HEuYfq7k;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HEuYfq7k;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Deepak Rawat <drawat@vmware.com>,
	Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.4 24/56] drm/vmwgfx: Fix a buffer object leak
Date: Mon, 14 May 2018 08:48:29 +0200
Message-Id: <20180514064757.216460871@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421312576078246?=
X-GMAIL-MSGID: =?utf-8?q?1600421312576078246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 13f149d47392782baafd96d54d4e65f3b5ca342f upstream.

A buffer object leak was introduced when fixing a premature buffer
object release. Fix this.

Cc: <stable@vger.kernel.org>
Fixes: 73a88250b709 ("Fix a destoy-while-held mutex problem.")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1991,6 +1991,7 @@ void vmw_kms_helper_resource_finish(stru
 		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, ctx->buf,
 					     out_fence, NULL);
 
+	vmw_dmabuf_unreference(&ctx->buf);
 	vmw_resource_unreserve(res, false, NULL, 0);
 	mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 }
