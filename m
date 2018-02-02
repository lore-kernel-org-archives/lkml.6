Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227lnSAetjjTY2WTGcNKnYb4r9dfWSPC9RDYRtveFvGOag3yvTYa+PnzSAjcNNNuM4vdJFRs
ARC-Seal: i=1; a=rsa-sha256; t=1517590864; cv=none;
        d=google.com; s=arc-20160816;
        b=c9SYPDjfina2/UZSS8Lke2ln/unqg98XuLOPunQ3kXeqLQxW7J6fsHic/B9sEkDYqh
         RrPVLolvJ6OLL/7kkGEHb1OJVouYRc0vAWVfaQ4VgCudRgqtH8pBrfpuHdALN3nA9MTS
         tjMEVcQx6d/ekjSsx0TjOntyca4+vN/ZLHBdcs7zWYg7h/2Zq/j3hoH865gH2dfx8MPZ
         zuJ0bWQaSaqu+zGJFwcUIYD/nsWUltXnvgEJgJSu11snCQ3C8hXAP+tJjOyEnxCkFLh2
         cvsKe6PBqMSBZIWcfPno3NgZcqemHiUZlJfEjkDjq2sP/ypBxiXHw/EcB4FQJpBQjKAy
         JEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fgHKzVu75OtG8FGbB1usZbsAysgcu7/zDBudv06/2iA=;
        b=cB2EQOqllKppgzeX5kZvtpjiRtKH1pfV1zBEQ+/466ybhg14ZBxWxd4+EzIhAgueI3
         vIJqAGUyrDtOiR54sD/Zc9bcj8yaoHdq1A/cUccT5lNY4MHkWYWtw0dCKSwoYlB3Qbk5
         2aaTF8npKH6MSPBh3Vmp3Fp+AhgPP+wKJYRE2VG2jQOXVEn0JoZrd1jwecbekM5QUr7R
         sqkLe5/zifmayX/+4Gn7tmFa/4tJC92K4rfdkta3I/++k9aTLTnvhD/gTqqw8u6DbOeO
         D2pcBO1hCJI5/tPQm0ITAV+mNnCN0Y3AyJFEtBRIMQfhN7hFU9klrOZeZHM81aqKpPqB
         kiKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasily Averin <vvs@virtuozzo.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 40/67] grace: replace BUG_ON by WARN_ONCE in exit_net hook
Date: Fri,  2 Feb 2018 17:58:09 +0100
Message-Id: <20180202140819.992149680@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309358674707017?=
X-GMAIL-MSGID: =?utf-8?q?1591309358674707017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>


[ Upstream commit b872285751c1af010e12d02bce7069e2061a58ca ]

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs_common/grace.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -104,7 +104,9 @@ grace_exit_net(struct net *net)
 {
 	struct list_head *grace_list = net_generic(net, grace_net_id);
 
-	BUG_ON(!list_empty(grace_list));
+	WARN_ONCE(!list_empty(grace_list),
+		  "net %x %s: grace_list is not empty\n",
+		  net->ns.inum, __func__);
 }
 
 static struct pernet_operations grace_net_ops = {
