Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrY0KPXEcz9TU+lWZyKtBAHl5HdHQFxBTj8tio/vsNfbKI3/GJRlHJ/G6IfVrIzdwTFkf6z
ARC-Seal: i=1; a=rsa-sha256; t=1525767427; cv=none;
        d=google.com; s=arc-20160816;
        b=NqrhKsnpFUq0VGuC781E86sci3DeV8VxNmijCLz63Ym1oF5YXcSeOh7n+nzU0rffLk
         /KQ+94KR3CwMbQ+Msj1GC29fNg6tjLrtZHPoRzXwwnPVATDHUQ0ZKYg/eHv1aksnN/qn
         T2a6jpmJOuRFKlRImTX8CUjB/yEkLW+I+7c5z+3UWBS57RIKuq+X3noFk5sF/zyl1VuA
         F1enUmMBJo6Vgtf2o8rJa3H63wFXUYAKJIk2jxXGPVPWpzfTo6Ku8Cw36h3OTZSH9Yn8
         AqEQUwc/wvsOd139VW4jcej7jpYS1njz+4eEmatya5DyxlqQlu4vt2WrXkK8K7bmOdTJ
         ASuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IKt9P+AFOHC/vUxxx6hbqQ2vPQ/idzAgALAlVkdfzS4=;
        b=XC4EGrMlqW8QuJ58mKLdR5ao8T3JF+K498JwdakVlWOrOXtet9wYarKWq7HOR88LJH
         IkD3Ys2GMjCeH49QA8Y74jrcLs3CYCqWgFZrvHc3DxCxsnsJ+hNDRqT7hbdylM3MII1u
         TbNPm/uDHAQhz6Ihvi5jyTnmPwtdicvsHauIQm4LfL/3dhbZ3jumk9P3LY6EkDsUmCsp
         nYMwVIWyr4GkMBBIJxQET6cSc0swDvbMpptxyFEjDW0fwKTrkb+dJRjxWxyWVN6Y1BPy
         vhZMfBoC4tYuCwC7/CqRn813gw9TJWUmJsqpPuBCENDd9VQREDD+vzLbMc2YhDbBSKaK
         nltQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K4iHz6FF;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=K4iHz6FF;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Deepak Rawat <drawat@vmware.com>,
	Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.9 22/32] drm/vmwgfx: Fix a buffer object leak
Date: Tue,  8 May 2018 10:11:02 +0200
Message-Id: <20180508074012.487076678@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882831936000482?=
X-GMAIL-MSGID: =?utf-8?q?1599883105645028134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2014,6 +2014,7 @@ void vmw_kms_helper_resource_finish(stru
 		vmw_kms_helper_buffer_finish(res->dev_priv, NULL, ctx->buf,
 					     out_fence, NULL);
 
+	vmw_dmabuf_unreference(&ctx->buf);
 	vmw_resource_unreserve(res, false, NULL, 0);
 	mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 }
