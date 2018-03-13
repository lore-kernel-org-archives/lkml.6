Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuWASgx6SVJ646X5btCc5nmLI1zN+EDBCeV/NbWtkEcYaXmnnyboKuN1LCNSjKLwlTRbok3
ARC-Seal: i=1; a=rsa-sha256; t=1520955550; cv=none;
        d=google.com; s=arc-20160816;
        b=N2CNNN+yhPt0pTEihX+TUbt8geLleXohsVZ+AdsyKVN4Ag6/8zNJR9+Dng7e9TilTt
         CSZYzCAD3oU6WVgn48cmJczEgVl3+LWeWy38MXHJNGSPJs3kv74ndGi8t815nO/00x0x
         tGwDI0uyjZwzKkYXvceHvQR2RoCEK0QYEgRVk4KjSDhTQlM0xnkI8KaXg2svNhwIKZDV
         C5wXfcQB9KefX3zbO0PMaVpvbV0698/3KkeZrLwQMsyxa045GVlDkb20u2F1FAUjJJhm
         0or5QAM+dbRE4lgEgRipIvM8Bsf5CTLKdyk4FFF99Gach/4ag0fFAaC6bIl4QgvgQbGJ
         rJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FKXHx8ffzeMv7EAGaLdbGJ+dNNlnY1WK6/FxvClQgCo=;
        b=WBCBYAwR6oLZkdKH2DEcCnQoga9vnVlNRbwu6tfHkHjn4zj6A1ELayENwHCMZS4AFf
         yi3LJlcKnTHE0XXgltVnVazmbWcNhPoQZ9WWRFBEOwwkioFiZIUSY2b87d4PR8Ibeakd
         6/vfIDVRM8YjffFbFH4CVZ0SYAr4yS6DXXoAQzAQMaouNWo8uKZ3jXc20BUpoUxR8c4t
         S+Oc1xopULAxradgFGPs7UcftKSErXV+e3T8maas0vBhDJ7ZcP8lY8nSFevBDRkUOXFV
         +ZCmZOKsOHr1p85uOiN76gUzWgFjZfY6EDhjOxYWFBkP+Jj1oQDXSN8QaiH55Rg9ewRw
         68HA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH 4.14 088/140] virtio_ring: fix num_free handling in error case
Date: Tue, 13 Mar 2018 16:24:51 +0100
Message-Id: <20180313152504.054138548@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836899953232634?=
X-GMAIL-MSGID: =?utf-8?q?1594837486735951245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.bie@intel.com>

commit e82df670235138575b37ff0ec24412a471efd97f upstream.

The vq->vq.num_free hasn't been changed when error happens,
so it shouldn't be changed when handling the error.

Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_ring.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -428,8 +428,6 @@ unmap_release:
 		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
 	}
 
-	vq->vq.num_free += total_sg;
-
 	if (indirect)
 		kfree(desc);
 
