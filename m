Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AB8JxZrabb8+VDLRxTaITVIOS0bNeglMjBV5mL/CM0jETRYrHcMFPo79lhuhEw566d6ro4kYRkQo
ARC-Seal: i=1; a=rsa-sha256; t=1525687847; cv=none;
        d=google.com; s=arc-20160816;
        b=XHj3TfK7ra5BqjwoBT9BQruEG089YzBqguSYG0ncHll77sUylPAZ/WOmPi0g1eG5pC
         BjHvCrOz1XD9me373TCtt5awLTNWiiik2UIa3zgrCQFMeSDEX+Kh0/lNSYv5wWcOJF3t
         Vpkyit7VL0fdYkVSJTEyomgMrGEFu03e18R4x8QRUHGreaH3Hf5H76YxEGNj/CCgIZPr
         BTLiyAn5l7EoLTtAD6MMKljSoFFzyhBF9kUd9K5KJHyrdKzKzT0EPZ2tkzz8Z1BzHb5d
         dl0nGMGCcnGfwVjrfx7gyuwWqKDba8Uq/c8KuL/xhCDabLy95XOepDiCrXVz5kg9DJRc
         igdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=8qStYlV4fic3m2auDQUyK88WjbzueG03WVNAmvAcbmA=;
        b=lqXnbCgJdcPd6sWdN/BhQOHVq4MuT2CWP7HsjIyj0WDRD0aqppUZcHUjw/VmKJLB57
         FFy4kN/flDXCQ9crulLS+GicSOs3sGDEak5FN6Z+tdoogBYUN5pDi6eX1ePEDF3r+0Br
         avVeIS0WkX3hHcgVaCzz+B2HoP3vyxo8D713yu9I7fudic7VYmO6vZDWmfWQNI08sLkX
         Sjs8sJUd+bB80DMdmRAA2aJl1rbh9/im28XB6mQ6ExYaCT0r0PzOSjs8xSSTFrsesPoS
         M6PXOPVW/xb9COgHZJlzryeLp93VwqIMtAWKGynTucd8VNj+FrKR8BDGNGuwzmOTEShy
         /zeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: [PATCH] driver core: Don't ignore class_dir_create_and_add() failure.
To: Greg KH <gregkh@linuxfoundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+df47f81c226b31d89fb1@syzkaller.appspotmail.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, Johannes Berg <johannes@sipsolutions.net>
References: <0000000000000390eb056b77596d@google.com>
 <20180505164041.GD7746@kroah.com>
 <095bc684-0029-0b2e-5e28-23376174ca02@gmail.com>
 <20180505220721.GA10829@kroah.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <7e25235d-0a11-87fb-cf81-56d6c13f40b0@I-love.SAKURA.ne.jp>
Date: Mon, 7 May 2018 19:10:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180505220721.GA10829@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599639621235468078?=
X-GMAIL-MSGID: =?utf-8?q?1599799660497928283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is hitting WARN() at kernfs_add_one() [1].
This is because kernfs_create_link() is confused by previous device_add()
call which continued without setting dev->kobj.parent field when
get_device_parent() failed by memory allocation fault injection.
Fix this by propagating the error from class_dir_create_and_add() to
the calllers of get_device_parent().

[1] https://syzkaller.appspot.com/bug?id=fae0fb607989ea744526d1c082a5b8de6529116f

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+df47f81c226b31d89fb1@syzkaller.appspotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
---
 drivers/base/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816..d680fd0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1467,7 +1467,7 @@ class_dir_create_and_add(struct class *class, struct kobject *parent_kobj)
 
 	dir = kzalloc(sizeof(*dir), GFP_KERNEL);
 	if (!dir)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	dir->class = class;
 	kobject_init(&dir->kobj, &class_dir_ktype);
@@ -1477,7 +1477,7 @@ class_dir_create_and_add(struct class *class, struct kobject *parent_kobj)
 	retval = kobject_add(&dir->kobj, parent_kobj, "%s", class->name);
 	if (retval < 0) {
 		kobject_put(&dir->kobj);
-		return NULL;
+		return ERR_PTR(retval);
 	}
 	return &dir->kobj;
 }
@@ -1784,6 +1784,10 @@ int device_add(struct device *dev)
 
 	parent = get_device(dev->parent);
 	kobj = get_device_parent(dev, parent);
+	if (IS_ERR(kobj)) {
+		error = PTR_ERR(kobj);
+		goto parent_error;
+	}
 	if (kobj)
 		dev->kobj.parent = kobj;
 
@@ -1882,6 +1886,7 @@ int device_add(struct device *dev)
 	kobject_del(&dev->kobj);
  Error:
 	cleanup_glue_dir(dev, glue_dir);
+parent_error:
 	put_device(parent);
 name_error:
 	kfree(dev->p);
@@ -2701,6 +2706,11 @@ int device_move(struct device *dev, struct device *new_parent,
 	device_pm_lock();
 	new_parent = get_device(new_parent);
 	new_parent_kobj = get_device_parent(dev, new_parent);
+	if (IS_ERR(new_parent_kobj)) {
+		error = PTR_ERR(new_parent_kobj);
+		put_device(new_parent);
+		goto out;
+	}
 
 	pr_debug("device: '%s': %s: moving to '%s'\n", dev_name(dev),
 		 __func__, new_parent ? dev_name(new_parent) : "<NULL>");
-- 
1.8.3.1
