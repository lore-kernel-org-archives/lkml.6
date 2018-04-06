Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KoZWQonyMqZKK3hGd1a6y01qUD+now513jgfRUjxs+R0/XeG4Mj0gd3lN1aEldTBzEEFd
ARC-Seal: i=1; a=rsa-sha256; t=1523021260; cv=none;
        d=google.com; s=arc-20160816;
        b=Yhk5hTjb75OVSLhxyWCo6k7dGUmdtQFCbNmkidZZzbZ5ushIXw+DpCKs2MLElar/R+
         tzOHJGpidMwtzq/cNURl2vrnx+Ck+qmTR/q3g9Yopwe15qY2h6Llf1XZ7e+BQBE3oZbq
         BZWpbEW6zzIwAJkJXJUTEp00pF2XgskG4A98HPm09ieGs3pJmx4534/dtC5NFzbkvXDf
         wY5arfNBIcqUlckSWR1eFQGA8qv/2vmzCbDhP0vWdpCgReeRfI6sfl47BiZtsUAAsi83
         wbnzzg55Erk3EghwiV4hBNrcptxSVzlBt4WWtUyzYtBtuhwKyO8CUAdbGZZu7RrxxH8m
         dpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8QcBWCl6iA2dSk2JuQjFguGvuNtrao2U0q8w+ck9m7Y=;
        b=zFagED/odIq7Vu1CsZIIkkqmvzSrMahVk4TM/krOUsl2SPVfOm4VdehCaCmaL8Yakz
         HpsFTjBHwwKmVjsC8icZuE8L/TuDiB8rZRdgVs1qhbByG9nRKX9NqfCJDvGV5Az2Tv1X
         5PI7UW6z37Lb5Qv9XB9RFxB6LNoXwKKZoBa7T3SdNRSHuz6kXrCGgfL6U+FDRVS0bzYu
         Tbn3feu3KDpBTnZnGmi5GfWOBvYbQ3zr6Eze4VPmIgOo+EQZRgkjgz4f8SRXPIHiEpiF
         w+yXPfLmWDPif3+R4X351YWn8LsEZAZz0DZTw8xvzV/nZbSBdGlcbFFNNnPsPvngUKhC
         PKoA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Wang Han <wanghan1995315@gmail.com>
Subject: [PATCH 3.18 48/93] xhci: Fix ring leak in failure path of xhci_alloc_virt_device()
Date: Fri,  6 Apr 2018 15:23:17 +0200
Message-Id: <20180406084227.016397377@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003541009821445?=
X-GMAIL-MSGID: =?utf-8?q?1597003541009821445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This is a stable-only fix for the backport of commit 5d9b70f7d52e
("xhci: Don't add a virt_dev to the devs array before it's fully
allocated").

In branches that predate commit c5628a2af83a ("xhci: remove endpoint
ring cache") there is an additional failure path in
xhci_alloc_virt_device() where ring cache allocation fails, in
which case we need to free the ring allocated for endpoint 0.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Wang Han <wanghan1995315@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-mem.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1032,7 +1032,8 @@ int xhci_alloc_virt_device(struct xhci_h
 
 	return 1;
 fail:
-
+	if (dev->eps[0].ring)
+		xhci_ring_free(xhci, dev->eps[0].ring);
 	if (dev->in_ctx)
 		xhci_free_container_ctx(xhci, dev->in_ctx);
 	if (dev->out_ctx)
