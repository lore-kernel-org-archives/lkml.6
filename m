Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226scjUPwWgyog0EO24MstsWKddJdnK7x0U6+jvxDTg2+dxzJCFZ/pqRyWwHZFKjpVQmRc/L
ARC-Seal: i=1; a=rsa-sha256; t=1518709075; cv=none;
        d=google.com; s=arc-20160816;
        b=fUMINvvC+tFfVPvK5lwc6yY1HVY5hUjW57i9dJ0XpZ3hhlsIXvuojlMmlwZdCQTqBa
         HEJWHNoaXUnt9fZNJ+oCxEFTM9SfjbAlaDe4wRnr1hJC3Z3+Ri/kle7pcfRty/GYFSGW
         4WxoLdyi6TMkYig7L2xZI8MW7X7wSxlnyFrZ6fhgkHh4Iik70Eso2Vst35r3zXXLttsM
         GeJzn3GlRxgw+hdJu5AaArUG+yGBMtIagBkOWfddTkLUPF6MPmJ+LFh/CclBhNU6qogq
         OWEoHsCIk9+yMGtvqxFXticbzrqfeIn8S8EYVgCOaNsiTRZwLC/DG1e/inLnVnhgkp9p
         yglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ff38ysTjdcIHvUtbyhhGxBgMHEEXPDGJpYH8VUcm5Z0=;
        b=SprzF1LmwBNw2NU5Qq4KnRns6BNhEk5/q54vJMjvM/3IxneErthDoY12wndL48UmVO
         8V0FzHOZdotunilEEBhtHuzP0NmVHIJUIbLppBx/aZcKGIelhnHFbn5bY/3kWrTULDK6
         XcgHebmm8z0kJiubU0NprBlMtc28ocdm1I78HDh9qVvbkATZlAJtIJkMAozQc86txhxp
         eNfmWHIPOwgWr9P++ytvxtAFAJzjQYTuNFQJQLquqDbup7uUAuJhVGD1uFq+ioftOHAp
         Hfi9zOIwi30Lnfo2i3/HPxX9x31Zp+bssMbJyyfzKPtiXVRlNpsngyA4Jb3W9VwwTZAk
         Jvwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 182/195] btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker
Date: Thu, 15 Feb 2018 16:17:53 +0100
Message-Id: <20180215151715.348192237@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481077358124918?=
X-GMAIL-MSGID: =?utf-8?q?1592481887210045437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit f3038ee3a3f1017a1cbe9907e31fa12d366c5dcb upstream.

This function was introduced by 247e743cbe6e ("Btrfs: Use async helpers
to deal with pages that have been improperly dirtied") and it didn't do
any error handling then. This function might very well fail in ENOMEM
situation, yet it's not handled, this could lead to inconsistent state.
So let's handle the failure by setting the mapping error bit.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/btrfs/inode.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2101,8 +2101,15 @@ again:
 		goto out;
 	 }
 
-	btrfs_set_extent_delalloc(inode, page_start, page_end, &cached_state,
-				  0);
+	ret = btrfs_set_extent_delalloc(inode, page_start, page_end,
+					&cached_state, 0);
+	if (ret) {
+		mapping_set_error(page->mapping, ret);
+		end_extent_writepage(page, ret, page_start, page_end);
+		ClearPageChecked(page);
+		goto out;
+	}
+
 	ClearPageChecked(page);
 	set_page_dirty(page);
 out:
