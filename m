Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuXrqpQ7ZuLdLezQDeQJsSE/MlVKbvcg5hjqduNeSwla/VDzPGp339aJDYMw79ljcX16lzy
ARC-Seal: i=1; a=rsa-sha256; t=1519411721; cv=none;
        d=google.com; s=arc-20160816;
        b=SNd9v/62KUSJ1QVSVIdvXCKvUpMUCIxxhaO9ARiUiQ5NaOjfbxt0cU7aMF/NFM6K6A
         iRT5yK74889EJ/REcEhj5fFLo+WjeNvf3oZqfAIUJyt9f9EBfsaxctpIDLcugoCmvamI
         tw54vHhbm43obP08sg22zVbdcgp4OJJOhB0FGkvufFweP/bQMjjguCyUX6uo8L8kqMKv
         1jMri+0mP4f1XDwADYLeN0G+dblJcIowlaYVeE27H1+d5hIqgMFSJwcka+YcwcXtvJ/a
         Vy2iRCYtEL70H+Tl3w0kURWFmmvrVTDK/QmhGtYDVhFadCfjsmIeen6b6+jU+SQTK4mw
         PeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8Hr0WLNEq6gBuLKr5rja9+j6+Jva9Wcj/9IXpFF4AP8=;
        b=hyxobrel1J2lx1hOdWh9JxX1uxDPuBmR2YWUO5pnHSPhSALJu/P94Og0pXS/CtvdgO
         Ak53DlPJwNEIq8M2EV2AuYYymm3kQOYQQSFgRtPma9etX7KFuGRJyoa0MlxNTsxliE5H
         twhhceDE//I78I/apKJBIxTbmpvFdMiBHskmRhXdNHf+AOD4C19H66n6Ln3+EUWNlPKy
         UE42LK1PJqu7F4V4k+JZKI6dJdB4LliXzxPtUzflkPuoU/se7Sfpep0xmhYGKoqwrYhf
         Ks5olw6gopABZF79CcpsuI9pnzhIc1L/mVKmbY/1p/zyZ1+BOCY3mWRzYG3jnrlTlWQX
         Sbtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Karol Herbst <karolherbst@gmail.com>,
	Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.9 123/145] drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized
Date: Fri, 23 Feb 2018 19:27:09 +0100
Message-Id: <20180223170740.703577205@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218040549195447?=
X-GMAIL-MSGID: =?utf-8?q?1593218664783783256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b74c0a9969f25217a5e5bbcac56a11bee16718d3 upstream.

gcc-4.9 notices that the validate_init() function returns unintialized
data when called with a zero 'nr_buffers' argument, when called with the
-Wmaybe-uninitialized flag:

drivers/gpu/drm/nouveau/nouveau_gem.c: In function ‘validate_init.isra.6’:
drivers/gpu/drm/nouveau/nouveau_gem.c:457:5: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

However, the only caller of this function always passes a nonzero
argument, and gcc-6 is clever enough to take this into account and
not warn about it any more.

Adding an explicit initialization to -EINVAL here is correct even if
the caller changed, and it avoids the warning on gcc-4.9 as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-By: Karol Herbst <karolherbst@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -369,7 +369,7 @@ validate_init(struct nouveau_channel *ch
 {
 	struct nouveau_cli *cli = nouveau_cli(file_priv);
 	int trycnt = 0;
-	int ret, i;
+	int ret = -EINVAL, i;
 	struct nouveau_bo *res_bo = NULL;
 	LIST_HEAD(gart_list);
 	LIST_HEAD(vram_list);
