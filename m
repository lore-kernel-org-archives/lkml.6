Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbeBARJ3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:09:29 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:35515 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeBARJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:09:23 -0500
X-Google-Smtp-Source: AH8x224eqtuqOHaiPQKr0AqzSLzkZdXsEUpm4WsKnbvDezr9PHFKRXwfzvnlw0I45wYoADZcxRG16g==
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc: initramfs <initramfs@vger.kernel.org>,
        Taras Kondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
 <20180201020331.GA3774@rani.riverdale>
 <1517458921.3329.2.camel@linux.vnet.ibm.com>
 <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
 <1517500500.3974.45.camel@linux.vnet.ibm.com>
From: Rob Landley <rob@landley.net>
Message-ID: <875e5d2d-9ffe-14ab-090a-4a9632af0f35@landley.net>
Date: Thu, 1 Feb 2018 11:09:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517500500.3974.45.camel@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------90C15B2615831A93BBAB5CAD"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------90C15B2615831A93BBAB5CAD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 02/01/2018 09:55 AM, Mimi Zohar wrote:
> On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:
> 
>>> With your patch and specifying "root=tmpfs", dracut is complaining:
>>>
>>> dracut: FATAL: Don't know how to handle 'root=tmpfs'
>>> dracut: refusing to continue
>>
>> [googles]... I do not understand why this package exists.
>>
>> If you're switching to another root filesystem, using a tool that
>> wikipedia[citation needed] says has no purpose but to switch to another
>> root filesystem, (so let's reproduce the kernel infrastructure in
>> userspace while leaving it the kernel too)... why do you need initramfs
>> to be tmpfs? You're using it for half a second, then discarding it,
>> what's the point of it being tmpfs?
> 
> Unlike the kernel image which is signed by the distros, the initramfs
> doesn't come signed, because it is built on the target system.  Even
> if the initramfs did come signed, it is beneficial to measure and
> appraise the individual files in the initramfs.

You can still shoot yourself in the foot with tmpfs. People mount a /run
and a /tmp and then as a normal user you can go
https://twitter.com/landley/status/959103235305951233 and maybe the
default should be a little more clever there...

I'll throw it on the todo heap. :)

>> Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
>> is configured in, even when you're then going to overmount it with
>> something else like you're doing, let's just _remove_ the test. If it
>> can be tmpfs, have it be tmpfs.
> 
> Very much appreciated!

Not yet tested, but something like the attached? (Sorry for the
half-finished doc changes in there, I'm at work and have a 5 minute
break. I can test properly this evening if you don't get to it...)

Rob

--------------90C15B2615831A93BBAB5CAD
Content-Type: text/x-patch;
 name="initmpfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="initmpfs.patch"

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b98048b..a5b44b2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3771,8 +3771,14 @@
 			debug-uart get routed to the D+ and D- pins of the usb
 			port and the regular usb controller gets disabled.
 
-	root=		[KNL] Root filesystem
-			See name_to_dev_t comment in init/do_mounts.c.
+	root=		[KNL] Fallback root filesystem when not using initramfs
+			If initramfs contains an /init file to run as PID 1 the
+			kernel ignores this setting. When initramfs doesn't have
+			/init (or whatever rdinit= points to) the kernel calls
+			prepare_namespace() in init/do_mounts.c to mount another
+			filesystem over / and chroot into it, then looks for
+			/sbin/init in there. (And /etc/init, /bin/init, and
+			/bin/sh for historical reasons.)
 
 	rootdelay=	[KNL] Delay (in seconds) to pause before attempting to
 			mount the root filesystem
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.txt b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
index b176928..f3c57ba 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.txt
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.txt
@@ -67,6 +67,10 @@ A ramfs derivative called tmpfs was created to add size limits, and the ability
 to write the data to swap space.  Normal users can be allowed write access to
 tmpfs mounts.  See Documentation/filesystems/tmpfs.txt for more information.
 
+The kernel uses tmpfs for ramfs when CONFIG_TMPFS=y and no "root=" is
+specified in the kernel command line. If you can't stop yourself from
+specifying root= you can also use "root=tmpfs".
+
 What is rootfs?
 ---------------
 
@@ -236,22 +240,10 @@ An initramfs archive is a complete self-contained root filesystem for Linux.
 If you don't already understand what shared libraries, devices, and paths
 you need to get a minimal root filesystem up and running, here are some
 references:
-http://www.tldp.org/HOWTO/Bootdisk-HOWTO/
-http://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
-http://www.linuxfromscratch.org/lfs/view/stable/
-
-The "klibc" package (http://www.kernel.org/pub/linux/libs/klibc) is
-designed to be a tiny C library to statically link early userspace
-code against, along with some related utilities.  It is BSD licensed.
 
-I use uClibc (http://www.uclibc.org) and busybox (http://www.busybox.net)
-myself.  These are LGPL and GPL, respectively.  (A self-contained initramfs
-package is planned for the busybox 1.3 release.)
-
-In theory you could use glibc, but that's not well suited for small embedded
-uses like this.  (A "hello world" program statically linked against glibc is
-over 400k.  With uClibc it's 7k.  Also note that glibc dlopens libnss to do
-name lookups, even when otherwise statically linked.)
+  http://www.tldp.org/HOWTO/Bootdisk-HOWTO/
+  http://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
+  http://www.linuxfromscratch.org/lfs/view/stable/
 
 A good first step is to get initramfs to run a statically linked "hello world"
 program as init, and test it under an emulator like qemu (www.qemu.org) or
@@ -264,11 +256,12 @@ User Mode Linux, like so:
   int main(int argc, char *argv[])
   {
     printf("Hello world!\n");
-    sleep(999999999);
+    sleep(999999999); // because if PID 1 exits the kernel panics
   }
   EOF
   gcc -static hello.c -o init
   echo init | cpio -o -H newc | gzip > test.cpio.gz
+
   # Testing external initramfs using the initrd loading mechanism.
   qemu -kernel /boot/vmlinuz -initrd test.cpio.gz /dev/zero
 
@@ -330,30 +323,3 @@ the above threads) is:
       http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1638.html
 
    and, most importantly, designed and implemented the initramfs code.
-
-Future directions:
-------------------
-
-Today (2.6.16), initramfs is always compiled in, but not always used.  The
-kernel falls back to legacy boot code that is reached only if initramfs does
-not contain an /init program.  The fallback is legacy code, there to ensure a
-smooth transition and allowing early boot functionality to gradually move to
-"early userspace" (I.E. initramfs).
-
-The move to early userspace is necessary because finding and mounting the real
-root device is complex.  Root partitions can span multiple devices (raid or
-separate journal).  They can be out on the network (requiring dhcp, setting a
-specific MAC address, logging into a server, etc).  They can live on removable
-media, with dynamically allocated major/minor numbers and persistent naming
-issues requiring a full udev implementation to sort out.  They can be
-compressed, encrypted, copy-on-write, loopback mounted, strangely partitioned,
-and so on.
-
-This kind of complexity (which inevitably includes policy) is rightly handled
-in userspace.  Both klibc and busybox/uClibc are working on simple initramfs
-packages to drop into a kernel build.
-
-The klibc package has now been accepted into Andrew Morton's 2.6.17-mm tree.
-The kernel's current early boot code (partition detection, etc) will probably
-be migrated into a default initramfs, automatically created and used by the
-kernel build.
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7cf4f6d..62232f3 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -603,7 +603,6 @@ void __init prepare_namespace(void)
 	sys_chroot(".");
 }
 
-static bool is_tmpfs;
 static struct dentry *rootfs_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
@@ -613,7 +612,7 @@ static struct dentry *rootfs_mount(struct file_system_type *fs_type,
 	if (test_and_set_bit(0, &once))
 		return ERR_PTR(-ENODEV);
 
-	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
+	if (IS_ENABLED(CONFIG_TMPFS))
 		fill = shmem_fill_super;
 
 	return mount_nodev(fs_type, flags, data, fill);
@@ -632,13 +631,7 @@ int __init init_rootfs(void)
 	if (err)
 		return err;
 
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs"))) {
-		err = shmem_init();
-		is_tmpfs = true;
-	} else {
-		err = init_ramfs_fs();
-	}
+	err = IS_ENABLED(CONFIG_TMPFS) ? shmem_init() : init_ramfs_fs();
 
 	if (err)
 		unregister_filesystem(&rootfs_fs_type);

--------------90C15B2615831A93BBAB5CAD--
