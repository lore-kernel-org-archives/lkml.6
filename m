Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtygP3sVrmcho7EbN221ne8wFM0J6QMB8oJ6Ma73ftU/h3euq7TxRuY5l0MEhi5IUy0lllI
ARC-Seal: i=1; a=rsa-sha256; t=1521214354; cv=none;
        d=google.com; s=arc-20160816;
        b=0NZ72MdRWkNUySe+xB5VOIoDKt466rJjTeD1ac22oQHONp2TvwaowAj+LVfmecDPLO
         ubItOvNbydHPIodb0DdEhHMGO6bJXbE7gzwpsM3jhAjSR8rLkcPpb6C2s8mJ+Z5npO0Z
         X7rY3bOXqE+aO5yA+/37lXPHy0bDT4wtPK0kS0XEkJVpG0WD4ZzxqdIHiPwxJC4YBKLp
         UiyPYx+/dXqJYWIRSkpF0wRpN5lDgy+FEiOTW+bGdsexYhD1RR5RRBOSvbjIdSXoMIW2
         Ch4VzfOEzlSvS0RDCZwRM4wPAHiHobGadeVpE12A3kTglVC3OHBu4ZRg97TxUmLXgzVJ
         wbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DShnVNkXXZREQchijAe6hswxI47FKvKob+M7GqFBfOc=;
        b=VZ669WYEEmOnFEQpuBntIAERPRBxYjn0GkQzIHwjzS6W69/UclFad1KK5oz62ESLuF
         QMHzFTQUnoxC7NqT33gkdgxxlHneY4LXTEFqSbeXV5x6xCT5R0B8SdRrq8jRK+yK8JvF
         wj8DSbT4tB31Jhf/oUOFnNvVl78LT+RGs2SRgbc7KciC5Ylgck8F53aO8vMbCd/ZYLT7
         XPQhAcApgHZAuLzpLvvcYoVetMfqre8xtmkXA7c428ZdjCmVJ//r9+11nlWM2FOlv/FG
         h9sAWs/WvUZFj73ng61FGxvoOsMCgJZOJxPaV4DG+enwx9c5pbu6PEk1Oq1c+llpczOJ
         IXEw==
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
Subject: [PATCH 4.9 64/86] ext4: inplace xattr block update fails to deduplicate blocks
Date: Fri, 16 Mar 2018 16:23:27 +0100
Message-Id: <20180316152321.687698483@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108677136778773?=
X-GMAIL-MSGID: =?utf-8?q?1595108862931120311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -837,8 +837,6 @@ ext4_xattr_block_set(handle_t *handle, s
 				if (!IS_LAST_ENTRY(s->first))
 					ext4_xattr_rehash(header(s->base),
 							  s->here);
-				ext4_xattr_cache_insert(ext4_mb_cache,
-					bs->bh);
 			}
 			ext4_xattr_block_csum_set(inode, bs->bh);
 			unlock_buffer(bs->bh);
@@ -959,6 +957,7 @@ inserted:
 		} else if (bs->bh && s->base == bs->bh->b_data) {
 			/* We were modifying this block in-place. */
 			ea_bdebug(bs->bh, "keeping this block");
+			ext4_xattr_cache_insert(ext4_mb_cache, bs->bh);
 			new_bh = bs->bh;
 			get_bh(new_bh);
 		} else {
