Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49SVW0omQxXa4ZzHAOKjlugQbBZXejyz6RN0bLP5/+AZAN1gzjpKKRmlWs4E5GnoecSVxvT
ARC-Seal: i=1; a=rsa-sha256; t=1523022217; cv=none;
        d=google.com; s=arc-20160816;
        b=qTNlwCxBLce85oPY2pkW9gRVZTEbH4ZaC5WmWD0XkpuOm58WVEXwXhol7PbsZCvOSO
         Gvmk0OiQAujoQN3yJds+j9M6mrhDwjpeqYCeZsHYLbVWPLTDIOBDJ3diRBiztO499uYM
         HhiaVdCK0/92yaY3ntE+C5RDfu4jL0exywJ4ZUGBl9yY129tU8sqjypnFy405p4nqlBg
         PFaoRhNCzA2k/J5Vvya1flr4mGPxVXMLwdZn4I/PepzkS0TmYJMC+JnhcbiN2oNLoy6C
         FMKq4TTLCGxcA6fGMkhau08CSSPbI1kcpXBEaoouxA/kEtRgfYo5ayUBAVEWzAthPRJH
         EoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5suLb1OF0pV3xeiaLv/HXHYIuEzceW6hePW471jsl9A=;
        b=dX7Jp2m24bj9cs0vz4G9nrkxxaUXz/f9QwwZrzJzJtoxyZRiJw7TBxaWXWNolKQ8qr
         4oSwaeHYG8u7NQwOdX4MnhfMA/lkgDB43nwETcMYON33fhyJGBOpbRgb/QWnhjxbVdf8
         T9JbtOZ9uQXR0YuD1sScb0uAfHKNkQMwjYaKPzYppas90J35BDI8l8hAPQhgXmWO3arN
         zr8Nw66p0c1LQNKyPN4US+kVvaEP75nbYbilUDkzJtQt1hXmMfHmVx+XmLSjtP08jMbV
         B4uU7W2WKpna6BpAMBkc/QIGp40UI8zv9aQwu1onu/oqyFHU7pESEnSaYVtK3OkVreEt
         neoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 68/72] Fix slab name "biovec-(1<<(21-12))"
Date: Fri,  6 Apr 2018 15:24:43 +0200
Message-Id: <20180406084353.930147205@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004122031445123?=
X-GMAIL-MSGID: =?utf-8?q?1597004544651051239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit bd5c4facf59648581d2f1692dad7b107bf429954 upstream.

I'm getting a slab named "biovec-(1<<(21-12))". It is caused by unintended
expansion of the macro BIO_MAX_PAGES. This patch renames it to biovec-max.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v4.14+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -43,9 +43,9 @@
  * break badly! cannot be bigger than what you can fit into an
  * unsigned short
  */
-#define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
+#define BV(x, n) { .nr_vecs = x, .name = "biovec-"#n }
 static struct biovec_slab bvec_slabs[BVEC_POOL_NR] __read_mostly = {
-	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
+	BV(1, 1), BV(4, 4), BV(16, 16), BV(64, 64), BV(128, 128), BV(BIO_MAX_PAGES, max),
 };
 #undef BV
 
