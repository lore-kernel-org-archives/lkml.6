Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeFDHGB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753907AbeFDHFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:05:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Kelly <mkelly@xevo.com>,
        Stable@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.16 28/47] iio:kfifo_buf: check for uint overflow
Date: Mon,  4 Jun 2018 08:58:40 +0200
Message-Id: <20180604065550.659359853@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kelly <mkelly@xevo.com>

commit 3d13de4b027d5f6276c0f9d3a264f518747d83f2 upstream.

Currently, the following causes a kernel OOPS in memcpy:

echo 1073741825 > buffer/length
echo 1 > buffer/enable

Note that using 1073741824 instead of 1073741825 causes "write error:
Cannot allocate memory" but no OOPS.

This is because 1073741824 == 2^30 and 1073741825 == 2^30+1. Since kfifo
rounds up to the nearest power of 2, it will actually call kmalloc with
roundup_pow_of_two(length) * bytes_per_datum.

Using length == 1073741825 and bytes_per_datum == 2, we get:

kmalloc(roundup_pow_of_two(1073741825) * 2
or kmalloc(2147483648 * 2)
or kmalloc(4294967296)
or kmalloc(UINT_MAX + 1)

so this overflows to 0, causing kmalloc to return ZERO_SIZE_PTR and
subsequent memcpy to fail once the device is enabled.

Fix this by checking for overflow prior to allocating a kfifo. With this
check added, the above code returns -EINVAL when enabling the buffer,
rather than causing an OOPS.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/buffer/kfifo_buf.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -27,6 +27,13 @@ static inline int __iio_allocate_kfifo(s
 	if ((length == 0) || (bytes_per_datum == 0))
 		return -EINVAL;
 
+	/*
+	 * Make sure we don't overflow an unsigned int after kfifo rounds up to
+	 * the next power of 2.
+	 */
+	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
+		return -EINVAL;
+
 	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
 			     bytes_per_datum, GFP_KERNEL);
 }
