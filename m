Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtfDmXNoiPUw5yV2bbsOH+XUK0MNXISzn+712GW7DKECcln5pPzlrEyLQoM2W9vuJ9BhPmu
ARC-Seal: i=1; a=rsa-sha256; t=1519410933; cv=none;
        d=google.com; s=arc-20160816;
        b=iVcdWB8zhdbUiBmsYUVjY3vHOV/Zk7z/mN7e1Mzouc6QdagFwInYXDpqtWwlFbc8V/
         5uAgZUOH6LwLdDHcnkUCNUJoAbL5qJn4S6Wa4I0SlDXKSKOkQls5gFcG/lWYghM5aN3O
         O+xYV+54gxVdgNGTPj3nKdw/cmxkR/MY21Ns9/JUWGF8mWhZC1ASDf8tW0Mkd7bAMcfv
         F0TDMqSMFqEAJsggBQACx7O3bcdJHSXNh6RfwB5G1OZRu1c9CxT2EUIzcxHw5py05C8y
         LQRLNn0SthVR5izu0kDMJFVDNcwInnwsx7SjidAta3Lj3GVWYbOzb4YJoQmKZo6F7+2R
         OjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N8lZ3/HyiyzpHfRB6dWQwESiCi0jWkhOmeamYDw40VU=;
        b=Kd4UjCB5ZfSu1oqdoYG7gFzrLlN7Ci9SlYolooivbUPl5tVKdQJaIg52ym8kqymSNa
         r40LrDcHu5VjBdxGs8Dd1cCVo8NHhiI4G6O18mIrauYHpy3hFJ38vqXE0OzgIfx37T5/
         H8e718YqwODZ+fO5iC/WSpilEGjwbZajw0uHvVnNPfkrrqxqqdhwy0BwKA79L48LVtk6
         Y5J6gljO6WmDy34IcjQt+IpXrdrt9LaxAuJAO93SoE0oree1cPRUuDyi2vGe1JSqqk8v
         /TXLlPBknE7ou8JMC0sk58q7VMNTYvq4UmgIXvIcX75xApeqZeEK62ZqsDZ+FAt+e4TQ
         gDEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Ladi Prosek <lprosek@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.4 062/193] virtio_balloon: prevent uninitialized variable use
Date: Fri, 23 Feb 2018 19:24:55 +0100
Message-Id: <20180223170335.670790147@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217838247979930?=
X-GMAIL-MSGID: =?utf-8?q?1593217838247979930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit f0bb2d50dfcc519f06f901aac88502be6ff1df2c upstream.

The latest gcc-7.0.1 snapshot reports a new warning:

virtio/virtio_balloon.c: In function 'update_balloon_stats':
virtio/virtio_balloon.c:258:26: error: 'events[2]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:260:26: error: 'events[3]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:261:56: error: 'events[18]' is used uninitialized in this function [-Werror=uninitialized]
virtio/virtio_balloon.c:262:56: error: 'events[17]' is used uninitialized in this function [-Werror=uninitialized]

This seems absolutely right, so we should add an extra check to
prevent copying uninitialized stack data into the statistics.
>From all I can tell, this has been broken since the statistics code
was originally added in 2.6.34.

Fixes: 9564e138b1f6 ("virtio: Add memory statistics reporting to the balloon driver (V4)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -239,12 +239,14 @@ static void update_balloon_stats(struct
 	all_vm_events(events);
 	si_meminfo(&i);
 
+#ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
 				pages_to_bytes(events[PSWPIN]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
 				pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+#endif
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
