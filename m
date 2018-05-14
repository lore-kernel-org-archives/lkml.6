Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo3cTdG0FodyepvF0PyvSj7FBE9tnr0GihodLswplkKe2e87xlGRizrneNM6qLqqsTYnTnD
ARC-Seal: i=1; a=rsa-sha256; t=1526281064; cv=none;
        d=google.com; s=arc-20160816;
        b=QiLGnqNsnhhRJ3GKHwnVSt4dqds05O0daJkqiL/27y7mQlH+TzH98f0Ocz81evkj0i
         I6cqHeVurXYPGDSZVD8ob6S0zVV8A20NbKE8CfFLTPpT+iqFXSz25IyKG8s1irjIaom9
         MjAk2LVNR4eqO32+isw6MLtB/xogVVEdV/l63D83RLBFk7RefIfad5BYudai4bP/S5wE
         yrncTrV/CAciSsCp15ddD1mH7p75Okevq8FM73AFVvD7lEiI6M96wIRXnZkVbXYIlBJL
         yxRZpH3acSjT8I9ZFrHq3g2hCp6dLM2nw+qRCWsADajyXssYnL8gymP38COuchXYtERj
         /nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=F9CdQ1u3b7zgd35J7cQVFNOq6MYXoQ+TwuJ86WojnIk=;
        b=UpoWpOwFvqZwN9DLiGidadaPJfdkikzJ3GbrWv2xyhWTw2LWYDX2KTVpaVIXoFoS6q
         HvBDGWzvJ4yjQlmL1BUcsXyZwQiUKcU/X3x8b1Rs6Zh8tYuiDNS60Le/NQrXL3Ky0+XP
         94elO6nf7boq6fvYUq3k8MpLZlmG9Y9vos2346mFTRSab1eyG2N+AzqUmaDAeJuehGut
         rj1kXCm7oSctqKNr6USG+ri0WHhB006MegH1woJ33SxjPiMsFIa8Dz9nERABotBifPxD
         NLM2wy6vSPBvJPeQPPg1kkpigReF9sTJ7xGeGaHfk/FV2aS7C5yxQTXvo0wNetyRCxxY
         6WOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=swa1Qbci;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=swa1Qbci;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	"Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 4.14 33/62] ceph: fix rsize/wsize capping in ceph_direct_read_write()
Date: Mon, 14 May 2018 08:48:49 +0200
Message-Id: <20180514064818.184108161@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421693083966559?=
X-GMAIL-MSGID: =?utf-8?q?1600421693083966559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 3a15b38fd2efc1d648cb33186bf71e9138c93491 upstream.

rsize/wsize cap should be applied before ceph_osdc_new_request() is
called.  Otherwise, if the size is limited by the cap instead of the
stripe unit, ceph_osdc_new_request() would setup an extent op that is
bigger than what dio_get_pages_alloc() would pin and add to the page
vector, triggering asserts in the messenger.

Cc: stable@vger.kernel.org
Fixes: 95cca2b44e54 ("ceph: limit osd write size")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/file.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -873,6 +873,11 @@ ceph_direct_read_write(struct kiocb *ioc
 		size_t start = 0;
 		ssize_t len;
 
+		if (write)
+			size = min_t(u64, size, fsc->mount_options->wsize);
+		else
+			size = min_t(u64, size, fsc->mount_options->rsize);
+
 		vino = ceph_vino(inode);
 		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 					    vino, pos, &size, 0,
@@ -888,11 +893,6 @@ ceph_direct_read_write(struct kiocb *ioc
 			break;
 		}
 
-		if (write)
-			size = min_t(u64, size, fsc->mount_options->wsize);
-		else
-			size = min_t(u64, size, fsc->mount_options->rsize);
-
 		len = size;
 		pages = dio_get_pages_alloc(iter, len, &start, &num_pages);
 		if (IS_ERR(pages)) {
