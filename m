Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsfLx4xm1JJu0IRkmQXnmnwu47TMtKIN9NPhtxJBW+Uqq7XN8CPWyWsY9Z8fiHVp7oUghji
ARC-Seal: i=1; a=rsa-sha256; t=1521214177; cv=none;
        d=google.com; s=arc-20160816;
        b=RWHqIiDTt9Glc9W73UaEqqTek/e0g6SdvHi4rV/1kl+Jhmrm9QVlwUqg3iu/aoepda
         ufIk74Xv1NdegnvUkQu4fA3iVJwA8H2YJZY+YImojp28RTr3rqBvAfhswGzIPw2/oAY4
         0ueWwFOSeb0PVzAWsCaPc3unezMgFWuxIw5wBzeCFbMFfi0vfaV5XRaFLGo9lYggVDAh
         eDapUs/q1cc/2TozYlMnMyCwMwqiO1YIrr+SyjaQT/76KwjCns58PbcJuy3Gfi61NDq2
         zFfDbhk+RbhBvkG9J9nCyZ0YMNwgU534RCcusJA7V/cGWQf0j6ETH9UXS9vMM8a/stoS
         /x4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d9uSKXDyXbGDDhIGHPljwrlVvX9PlSDlb39g7cCSuQ8=;
        b=P5vtzBV6odD28Mq5sxFJkLfwgndUVO6iQ4MY3AShIATiQYBv5vk+90lRB3G8VL9Zgm
         DTvoz307NN4nwvZr8K3xRpp5D8tVDqgquAMPwLVBHKwhb7wb1rH3hSbuOnCyObC4m/F/
         tEYDJCH4jiqhLjViL2lf+buCoqB/HdGsgRd9sud9MuL2DcH8e46LC/f4dydQnAdVQkK1
         cYRPQMSlIRGrJegF9p4JvZlm++TdtqrFmSwL5eoqZ0O/XJDG4XqlIsG3qtLJH9zomoxV
         i0eKfE0yRYSVBBrr2p+VeL3BG7BdJGUM1xe2R5XudARoUaMVExmreMoIS+Pg2D+t3FQ3
         zR2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tahsin Erdogan <tahsin@google.com>,
	Theodore Tso <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.4 45/63] ext4: inplace xattr block update fails to deduplicate blocks
Date: Fri, 16 Mar 2018 16:23:17 +0100
Message-Id: <20180316152304.770115727@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108677136778773?=
X-GMAIL-MSGID: =?utf-8?q?1595108677136778773?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tahsin Erdogan <tahsin@google.com>

commit ec00022030da5761518476096626338bd67df57a upstream.

When an xattr block has a single reference, block is updated inplace
and it is reinserted to the cache. Later, a cache lookup is performed
to see whether an existing block has the same contents. This cache
lookup will most of the time return the just inserted entry so
deduplication is not achieved.

Running the following test script will produce two xattr blocks which
can be observed in "File ACL: " line of debugfs output:

  mke2fs -b 1024 -I 128 -F -O extent /dev/sdb 1G
  mount /dev/sdb /mnt/sdb

  touch /mnt/sdb/{x,y}

  setfattr -n user.1 -v aaa /mnt/sdb/x
  setfattr -n user.2 -v bbb /mnt/sdb/x

  setfattr -n user.1 -v aaa /mnt/sdb/y
  setfattr -n user.2 -v bbb /mnt/sdb/y

  debugfs -R 'stat x' /dev/sdb | cat
  debugfs -R 'stat y' /dev/sdb | cat

This patch defers the reinsertion to the cache so that we can locate
other blocks with the same contents.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -828,8 +828,6 @@ ext4_xattr_block_set(handle_t *handle, s
 				if (!IS_LAST_ENTRY(s->first))
 					ext4_xattr_rehash(header(s->base),
 							  s->here);
-				ext4_xattr_cache_insert(ext4_mb_cache,
-					bs->bh);
 			}
 			unlock_buffer(bs->bh);
 			if (error == -EFSCORRUPTED)
@@ -918,6 +916,7 @@ inserted:
 		} else if (bs->bh && s->base == bs->bh->b_data) {
 			/* We were modifying this block in-place. */
 			ea_bdebug(bs->bh, "keeping this block");
+			ext4_xattr_cache_insert(ext4_mb_cache, bs->bh);
 			new_bh = bs->bh;
 			get_bh(new_bh);
 		} else {
