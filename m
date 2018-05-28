Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423119AbeE1LF1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423091AbeE1LFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:05:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Wu <quark@fb.com>,
        Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.16 012/272] Btrfs: fix error handling in btrfs_truncate()
Date: Mon, 28 May 2018 12:00:45 +0200
Message-Id: <20180528100241.319016155@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit d50147381aa0c9725d63a677c138c47f55d6d3bc upstream.

Jun Wu at Facebook reported that an internal service was seeing a return
value of 1 from ftruncate() on Btrfs in some cases. This is coming from
the NEED_TRUNCATE_BLOCK return value from btrfs_truncate_inode_items().

btrfs_truncate() uses two variables for error handling, ret and err.
When btrfs_truncate_inode_items() returns non-zero, we set err to the
return value. However, NEED_TRUNCATE_BLOCK is not an error. Make sure we
only set err if ret is an error (i.e., negative).

To reproduce the issue: mount a filesystem with -o compress-force=zstd
and the following program will encounter return value of 1 from
ftruncate:

int main(void) {
        char buf[256] = { 0 };
        int ret;
        int fd;

        fd = open("test", O_CREAT | O_WRONLY | O_TRUNC, 0666);
        if (fd == -1) {
                perror("open");
                return EXIT_FAILURE;
        }

        if (write(fd, buf, sizeof(buf)) != sizeof(buf)) {
                perror("write");
                close(fd);
                return EXIT_FAILURE;
        }

        if (fsync(fd) == -1) {
                perror("fsync");
                close(fd);
                return EXIT_FAILURE;
        }

        ret = ftruncate(fd, 128);
        if (ret) {
                printf("ftruncate() returned %d\n", ret);
                close(fd);
                return EXIT_FAILURE;
        }

        close(fd);
        return EXIT_SUCCESS;
}

Fixes: ddfae63cc8e0 ("btrfs: move btrfs_truncate_block out of trans handle")
CC: stable@vger.kernel.org # 4.15+
Reported-by: Jun Wu <quark@fb.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9238,7 +9238,8 @@ static int btrfs_truncate(struct inode *
 						 BTRFS_EXTENT_DATA_KEY);
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN) {
-			err = ret;
+			if (ret < 0)
+				err = ret;
 			break;
 		}
 
