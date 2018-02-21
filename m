Return-Path: <idryomov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519229266; cv=none;
        d=google.com; s=arc-20160816;
        b=BiqxAhl+J4vGdxAQi0riFqkSS0TpPWoBg3SiKBHczu5LClcK4ppRSRviRRqK4iH+Uj
         CpspyDEr3ldvBkGCsObFwZPx5R0UYZEcMJ0ZUM08D053okQwBKHTM7bh8nVpowJ4XR+1
         TH/G259Dmyod4gquiMYbrlQwVUo8gKgsQqdR8fD48+nyiYAFd57FWhr1EvcXWdMwbUDZ
         wK9tgdGWfZr+oqJQTdFcj+jj+UQJ7ZefQCqnf/4glM7C/cMNzgzcydQiWdZDQX8dtJUf
         5B3hH3KF8CQQYI5wobSNbpqAhJBoIhH6u0ag0AG6t3xYEv9JqLCf6POlYzlxZM3oGPl0
         1o5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Muf93tsKc0/a8SBCjTPfJPwkuH3X6plZ5UKcDb/30Mo=;
        b=NkPBXk5Xn+i7iwGugjd+wgUAZnEqesVlQnQXYmc6wbWRjPCSBlR8Kt5jgoXVybZzCZ
         zrIZBFGqnMpfb3qKWgl6fqskaDS4yKKKoWXkpZ1ipZQvnwXELcyNXZdFTEy8Tu7YhBJF
         iMWSylbjkSSzoWms/jaFTkj4vXfKTcbImQkX1+J2/M8S8bwN0Rh5UX1SBq5sFy0TodVi
         t7gD/YVQl3mtbzP3FHw1tnW6lh3WdOPbaVPERST8wQltfzVICV5j6/SBLOoOTgclm51+
         fh5y23cpLER60QDIj9iV14xQnmnm9Hw1ekIEF4Clfru2jxnVo0U9L5aRuim4Y+H0Brow
         FYEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JudIFZr9;
       spf=pass (google.com: domain of idryomov@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=idryomov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JudIFZr9;
       spf=pass (google.com: domain of idryomov@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=idryomov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226yvJTcs49nfmICvAg+ewIyxy3Y5G5atla1ezVuDIVbR/SVPCdRhpn6vOUsrtCOJEh5SUKbkw2BSPXqlvG+urI=
MIME-Version: 1.0
In-Reply-To: <20180220090859.GA22737@mordor.localdomain>
References: <20180220090859.GA22737@mordor.localdomain>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 21 Feb 2018 17:07:45 +0100
Message-ID: <CAOi1vP8qU421g=3-kTVLGLV02o7kxSPXrpd-uHAaXgO=BZ779g@mail.gmail.com>
Subject: Re: [PATCH] block: rbd: update sysfs interface
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
	Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592910409201593402?=
X-GMAIL-MSGID: =?utf-8?q?1593027347482572037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:08 AM, Aishwarya Pant <aishpant@gmail.com> wrote:
> The existing sysfs interface has been updated to be in the same format
> as described in Documentation/ABI/README. This will be useful for
> scripting and tracking changes in the ABI. Attributes have been grouped
> by functionality and/or the date on which they were added.
>
> There are a couple of more changes:
> - The attributes have been annotated with file permissions RO/RW/WO.
> - Added description of the bus attribute supported_features
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-rbd | 202 +++++++++++++++++++-------------
>  1 file changed, 122 insertions(+), 80 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
> index f208ac58d613..9549e9b0fcf8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-rbd
> +++ b/Documentation/ABI/testing/sysfs-bus-rbd
> @@ -1,121 +1,163 @@
> -What:          /sys/bus/rbd/
> -Date:          November 2010
> +What:          /sys/bus/rbd/add
> +What:          /sys/bus/rbd/remove

Hi Aishwarya,

No need to group "add" and "remove" together.  Do them separate, like
"add_single_major" and "remove_single_major".

> +Date:          Jan, 2012
> +KernelVersion: v3.10

I think "add" and "remove" go back to v2.6.37.

>  Contact:       Yehuda Sadeh <yehuda@newdream.net>,
>                 Sage Weil <sage@newdream.net>

Remove Yehuda from the contact list here and everywhere else.

>  Description:
> +               add : (WO) Add rbd block device.
>
> -Being used for adding and removing rbd block devices.
> +               Usage: <mon ip addr> <options> <pool name> <rbd image name> [<snap name>]
>
> -Usage: <mon ip addr> <options> <pool name> <rbd image name> [<snap name>]
> +                $ echo "192.168.0.1 name=admin rbd foo" > /sys/bus/rbd/add
>
> - $ echo "192.168.0.1 name=admin rbd foo" > /sys/bus/rbd/add
> +               The snapshot name can be "-" or omitted to map the image
> +               read/write. A <dev-id> will be assigned for any registered block
> +               device. If snapshot is used, it will be mapped read-only.
>
> -The snapshot name can be "-" or omitted to map the image read/write. A <dev-id>
> -will be assigned for any registered block device. If snapshot is used, it will
> -be mapped read-only.
> +               remove: (WO) Remove rbd block device.
>
> -Usage: <dev-id> [force]
> +               Usage: <dev-id> [force]
>
> - $ echo 2 > /sys/bus/rbd/remove
> +                $ echo 2 > /sys/bus/rbd/remove
> +
> +               Optional "force" argument which when passed will wait for
> +               running requests and then unmap the image. Requests sent to the
> +               driver after initiating the removal will be failed. (August
> +               2016, since 4.9.)
>
> -Optional "force" argument which when passed will wait for running requests and
> -then unmap the image. Requests sent to the driver after initiating the removal
> -will be failed.  (August 2016, since 4.9.)
>
>  What:          /sys/bus/rbd/add_single_major
> -Date:          December 2013
> -KernelVersion: 3.14
> -Contact:       Sage Weil <sage@inktank.com>
> -Description:   Available only if rbd module is inserted with single_major
> +Date:          Dec, 2013
> +KernelVersion: v3.14
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               (WO) Available only if rbd module is inserted with single_major
>                 parameter set to true.
> -               Usage is the same as for /sys/bus/rbd/add.  If present,
> +
> +               Usage is the same as for /sys/bus/rbd/add. If present, this
>                 should be used instead of the latter: any attempts to use
> -               /sys/bus/rbd/add if /sys/bus/rbd/add_single_major is
> -               available will fail for backwards compatibility reasons.
> +               /sys/bus/rbd/add if /sys/bus/rbd/add_single_major is available
> +               will fail for backwards compatibility reasons.
> +
>
>  What:          /sys/bus/rbd/remove_single_major
> -Date:          December 2013
> -KernelVersion: 3.14
> -Contact:       Sage Weil <sage@inktank.com>
> -Description:   Available only if rbd module is inserted with single_major
> +Date:          Dec, 2013
> +KernelVersion: v3.14
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               (WO) Available only if rbd module is inserted with single_major
>                 parameter set to true.
> -               Usage is the same as for /sys/bus/rbd/remove.  If present,
> +
> +               Usage is the same as for /sys/bus/rbd/remove. If present, this
>                 should be used instead of the latter: any attempts to use
>                 /sys/bus/rbd/remove if /sys/bus/rbd/remove_single_major is
>                 available will fail for backwards compatibility reasons.
>
> -Entries under /sys/bus/rbd/devices/<dev-id>/
> ---------------------------------------------
> -
> -client_addr
> -
> -       The ceph unique client entity_addr_t (address + nonce).
> -       The format is <address>:<port>/<nonce>: '1.2.3.4:1234/5678' or
> -       '[1:2:3:4:5:6:7:8]:1234/5678'.  (August 2016, since 4.9.)
> -
> -client_id
> -
> -       The ceph unique client id that was assigned for this specific session.
> -
> -cluster_fsid
> -
> -       The ceph cluster UUID.  (August 2016, since 4.9.)
> -
> -config_info
> -
> -       The string written into /sys/bus/rbd/add{,_single_major}.  (August
> -       2016, since 4.9.)
> -
> -features
> -
> -       A hexadecimal encoding of the feature bits for this image.
>
> -major
> -
> -       The block device major number.
> -
> -minor
> +What:          /sys/bus/rbd/supported_features
> +Date:          Mar, 2017
> +KernelVersion: v4.11
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               (RO) Displays the features supported by the client software

the client software implementation -> rbd module

> +               implementation so that userspace can generate meaningful error
> +               messages and spell out unsupported features that need to be
> +               disabled.
> +
> +
> +What:          /sys/bus/rbd/devices/<dev-id>/size
> +What:          /sys/bus/rbd/devices/<dev-id>/refresh
> +What:          /sys/bus/rbd/devices/<dev-id>/current_snap
> +What:          /sys/bus/rbd/devices/<dev-id>/name
> +What:          /sys/bus/rbd/devices/<dev-id>/major
> +What:          /sys/bus/rbd/devices/<dev-id>/client_id
> +Date:          Aug, 2010
> +KernelVersion: v2.6.37
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               size:           (RO) The size (in bytes) of the mapped block
> +                               device.
>
> -       The block device minor number.  (December 2013, since 3.14.)
> +               refresh:        (WO) Writing to this file will reread the image
> +                               header data and set all relevant data structures
> +                               accordingly.
>
> -name
> +               current_snap:   (RO) The current snapshot for which the device
> +                               is mapped.
>
> -       The name of the rbd image.
> +               name:           (RO) The name of the rbd image.
>
> -image_id
> +               major:          (RO) The block device major number.
>
> -       The unique id for the rbd image.  (For rbd image format 1
> -       this is empty.)
> +               client_id:      (RO) The ceph unique client id that was assigned
> +                               for this specific session.
>
> -pool
>
> -       The name of the storage pool where this rbd image resides.
> -       An rbd image name is unique within its pool.
> +What:          /sys/bus/rbd/devices/<dev-id>/pool

"pool" also goes back to v2.6.37.

> +What:          /sys/bus/rbd/devices/<dev-id>/image_id

"image_id" was added in v3.7.

Having these documented is nice, but wrong versions and dates are worse
than none at all.  Please cross check the rest with git log/blame.

> +What:          /sys/bus/rbd/devices/<dev-id>/features
> +What:          /sys/bus/rbd/devices/<dev-id>/pool_id
> +Date:          Jul, 2012
> +KernelVersion: v3.10
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               pool:           (RO) The name of the storage pool where this rbd
> +                               image resides. An rbd image name is unique
> +                               within its pool.
>
> -pool_id
> +               image_id:       (WO) The unique id for the rbd image. (For rbd
> +                               image format 1 this is empty.)

image_id should be RO.

>
> -       The unique identifier for the rbd image's pool.  This is
> -       a permanent attribute of the pool.  A pool's id will never
> -       change.
> +               features:       (RO) A hexadecimal encoding of the feature bits
> +                               for this image.
>
> -size
> +               pool_idr:       (RO) The unique identifier for the rbd image's
> +                               pool. This is a permanent attribute of the pool.
> +                               A pool's id will never change.

pool_idr -> pool_id

>
> -       The size (in bytes) of the mapped block device.
>
> -refresh
> +What:          /sys/bus/rbd/devices/<dev-id>/parent
> +Date:          Oct, 2012
> +KernelVersion: v3.10
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               (RO) Information identifying the chain of parent images in a
> +               layered rbd image. Entries are separated by empty lines.
>
> -       Writing to this file will reread the image header data and set
> -       all relevant datastructures accordingly.
>
> -current_snap
> +What:          /sys/bus/rbd/devices/<dev-id>/minor
> +Date:          Dec, 2013
> +KernelVersion: v3.14
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               (RO) The block device minor number.
>
> -       The current snapshot for which the device is mapped.
>
> -snap_id
> +What:          /sys/bus/rbd/devices/<dev-id>/snap_id
> +What:          /sys/bus/rbd/devices/<dev-id>/config_info
> +What:          /sys/bus/rbd/devices/<dev-id>/cluster_fsid
> +What:          /sys/bus/rbd/devices/<dev-id>/client_addr
> +Date:          Aug, 2016
> +KernelVersion: v4.9
> +Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> +               Sage Weil <sage@newdream.net>
> +Description:
> +               snap_id:        (RO) The current snapshot's id.
>
> -       The current snapshot's id.  (August 2016, since 4.9.)
> +               config_info:    (RO) The string written into
> +                               /sys/bus/rbd/add{,_single_major}.
>
> -parent
> +               cluster_fsid:   (RO) The ceph cluster UUID.
>
> -       Information identifying the chain of parent images in a layered rbd
> -       image.  Entries are separated by empty lines.
> +               client_addr:    (RO) The ceph unique client
> +                               entity_addr_t (address + nonce). The format is
> +                               <address>:<port>/<nonce>: '1.2.3.4:1234/5678' or
> +                               '[1:2:3:4:5:6:7:8]:1234/5678'.

Thanks,

                Ilya
