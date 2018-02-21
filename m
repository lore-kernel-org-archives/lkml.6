Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226yFoDbYInkLl40LyxIt+XtafvCZy+7fMHV700LZl/eUOCpj9btJJA4SIlxWuoayewYqK6U
ARC-Seal: i=1; a=rsa-sha256; t=1519218537; cv=none;
        d=google.com; s=arc-20160816;
        b=BxvvX7nnrVw7eFAxbbFqwosYjDPc+HwZFKShaThMr6rcdOvP1sdou/cI2qHP/8eZQ8
         lq8sRmEcYkSp8xeP74vCjcTVkybNoGWvpKffkksah2gTHtKy9MD29QJDKr+yYaT59hJ8
         t8Cwh/MII2/zSWxxnvV0efCEnOBXTOkqJx2bjxh/FiPoekqEffjHbjlKJjpS4v5OQemZ
         +tg1Q0iil3Ffby/PnGJlls22CxqlZ0VkVKVhvIuGDRh4WCfropfsOWskVij0JenrRXg1
         L9ZOMdTR/QurLFZMcrdpO9ZAK0tIG1rG20zU2vciC8TGa3nrR+ZNUYtOzIagZIPNKXi6
         BZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3ptuJ51Rs7HbZlnE3uVygS+gNPzV0V2yqOV5v3feltA=;
        b=pE/WpxawcuQgB8d0u57WLS6Ol2Vx12SSbTOH4zBpObo974aBgBScZGLeGDnmRzazjJ
         AgpxjdM6/oWhEMKAa8Zbk0MiB2mzDcKfUnq6OnmcLjFSf4JjlMpbV/BSpcQ61THDsnRj
         gkYQa5frdld0VcIH1RwIByyKm1VTsEDbYf7JTSZM78FLCoMVS6ONed/kMza9IImxuCHl
         fdIjtAcfdvPjyof5vEBQXdsn1ODiDqRqI3kZxZbuuC2Oe82h6Tcboiobw1//kd6sRVTb
         YWe8qgNgOHyoOH3G2edlX0yfMfRbehueSiYoPcjWVVc6m4dNKkPprUuNc5Zidi4iy/or
         uBQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.15 057/163] platform/x86: wmi: fix off-by-one write in wmi_dev_probe()
Date: Wed, 21 Feb 2018 13:48:06 +0100
Message-Id: <20180221124533.615600146@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593016097107439174?=
X-GMAIL-MSGID: =?utf-8?q?1593016097107439174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit 6e1d8ea90932f77843730ada0bfea63093b7212a upstream.

wmi_dev_probe() allocates one byte less than necessary, thus
subsequent sprintf() call writes trailing zero past the end
of the 'buf':

    BUG: KASAN: slab-out-of-bounds in vsnprintf+0xda4/0x1240
    Write of size 1 at addr ffff880423529caf by task kworker/1:1/32

    Call Trace:
     dump_stack+0xb3/0x14d
     print_address_description+0xd7/0x380
     kasan_report+0x166/0x2b0
     vsnprintf+0xda4/0x1240
     sprintf+0x9b/0xd0
     wmi_dev_probe+0x1c3/0x400
     driver_probe_device+0x5d1/0x990
     bus_for_each_drv+0x109/0x190
     __device_attach+0x217/0x360
     bus_probe_device+0x1ad/0x260
     deferred_probe_work_func+0x10f/0x5d0
     process_one_work+0xa8b/0x1dc0
     worker_thread+0x20d/0x17d0
     kthread+0x311/0x3d0
     ret_from_fork+0x3a/0x50

    Allocated by task 32:
     kasan_kmalloc+0xa0/0xd0
     __kmalloc+0x14f/0x3e0
     wmi_dev_probe+0x182/0x400
     driver_probe_device+0x5d1/0x990
     bus_for_each_drv+0x109/0x190
     __device_attach+0x217/0x360
     bus_probe_device+0x1ad/0x260
     deferred_probe_work_func+0x10f/0x5d0
     process_one_work+0xa8b/0x1dc0
     worker_thread+0x20d/0x17d0
     kthread+0x311/0x3d0
     ret_from_fork+0x3a/0x50

Increment allocation size to fix this.

Fixes: 44b6b7661132 ("platform/x86: wmi: create userspace interface for drivers")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/wmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -933,7 +933,7 @@ static int wmi_dev_probe(struct device *
 			goto probe_failure;
 		}
 
-		buf = kmalloc(strlen(wdriver->driver.name) + 4, GFP_KERNEL);
+		buf = kmalloc(strlen(wdriver->driver.name) + 5, GFP_KERNEL);
 		if (!buf) {
 			ret = -ENOMEM;
 			goto probe_string_failure;
