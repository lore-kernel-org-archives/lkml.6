Return-Path: <fxysunshine@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520321950; cv=none;
        d=google.com; s=arc-20160816;
        b=GnNq40gPdWAEbl3Sjl0Tpqvh4b8v/xzSI3NHpkYhmDIWzNQqy5J0Y5YgLWzgKZ6/Gw
         P/We17enszbVVTXzvgEc9vz3VX7IdzmNgbQrxD6pBe7Sh43DUHnw2FTgB/A/MV14722z
         Ge/un8Ab7Z3yvFnRY1+aE2c8fCHp0IgmAg4gQOZ/sdWv/O2gHwuridjTnPdZZIKCI6Gi
         8ajfmRNW9NI7zn3JGeq2ldSBBZtai2Q3hUdH/0GQIZwTciWzdubgXyhgt6KFIbReePuf
         w7w/U0NVpM67P4RmxtPFsuzfOlil0OiRJSkUnbq87cUGUlwcxgDRqhd7Yo2SQy2UEIP5
         53Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=sxdb36fWpywNf2RFVdzkp0jmlWkJsmQeU4tW+Mp4ePY=;
        b=fXels38XB+VlwKoAtAtjJw37FTCQFabyRUyp1hMhpaZTdJaxtnnxzKDJvcySCOFJHq
         HzIFaIuIfre3gqF6TGQUgxXMCXUukD0SyV7gd17ymVFT42WVKWK6ZDFzHqquTY+fFQ5a
         O2Kh3IAiIoq4YVJWL8gnq2Xx76n0pfMJTNbPxU6ik8wsrOl5TVLlPTlNZE5LRRZPy7kc
         ge6x+TLWcTX4PAQUk/ENAUwSo9jBReGs0OvQa+iszcTD95A4ZWveRnLOdn9DOQdtVUqy
         CMoEQFj55ZBOcCFnEIWP3SIm7qsaSE/bxX/B0TZYEX5qMk9uI5P74tCUMODrep5J0lat
         NSSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WhiL7ZUJ;
       spf=pass (google.com: domain of fxysunshine@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fxysunshine@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WhiL7ZUJ;
       spf=pass (google.com: domain of fxysunshine@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=fxysunshine@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELudJv2+PYITJDWhHdwUegGp3pdtrLWJXhq82Ci/0nL3r3UXRIsxl9dw4RiYjaj1kyawtrPfZ3NG8Om6wbW+DAs=
MIME-Version: 1.0
In-Reply-To: <1519989607-16098-1-git-send-email-xinyong.fang@linux.alibaba.com>
References: <1519989607-16098-1-git-send-email-xinyong.fang@linux.alibaba.com>
From: =?UTF-8?B?5pa55paw5YuH?= <fxysunshine@gmail.com>
Date: Tue, 6 Mar 2018 15:39:09 +0800
Message-ID: <CAHzMrMyS8-P19+QrsJdazTJRuZ-fXsxu+-VzxHqZEqzLsrZafQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()
To: Xinyong <xinyong.fang@linux.alibaba.com>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	zhangjerry@google.com, mina86@mina86.com, plr.vincent@gmail.com,
	shuang.liu@intel.com, xulun@linux.alibaba.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a11401f28c932ee0566b9894c"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593824639393501354?=
X-GMAIL-MSGID: =?utf-8?q?1594173110271901273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a11401f28c932ee0566b9894c
Content-Type: text/plain; charset="UTF-8"

hi, balbi and folks,

could you help review or comment for the change. thanks

-
xinyong


2018-03-02 19:20 GMT+08:00 Xinyong <xinyong.fang@linux.alibaba.com>:

> When I debug a kernel crash issue in funcitonfs, found ffs_data.ref
> overflowed, While functionfs is unmounting, ffs_data is put twice.
>
> Commit 43938613c6fd ("drivers, usb: convert ffs_data.ref from atomic_t to
> refcount_t") can avoid refcount overflow, but that is risk some situations.
> So no need put ffs data in ffs_fs_kill_sb, already put in ffs_data_closed.
>
> The issue can be reproduced in Mediatek mt6763 SoC, ffs for ADB device.
> KASAN enabled configuration reports use-after-free errro.
>
> BUG: KASAN: use-after-free in refcount_dec_and_test+0x14/0xe0 at addr
> ffffffc0579386a0
> Read of size 4 by task umount/4650
> ====================================================
> BUG kmalloc-512 (Tainted: P        W  O   ): kasan: bad access detected
> ------------------------------------------------------------
> -----------------
>
> INFO: Allocated in ffs_fs_mount+0x194/0x844 age=22856 cpu=2 pid=566
>     alloc_debug_processing+0x1ac/0x1e8
>     ___slab_alloc.constprop.63+0x640/0x648
>     __slab_alloc.isra.57.constprop.62+0x24/0x34
>     kmem_cache_alloc_trace+0x1a8/0x2bc
>     ffs_fs_mount+0x194/0x844
>     mount_fs+0x6c/0x1d0
>     vfs_kern_mount+0x50/0x1b4
>     do_mount+0x258/0x1034
> INFO: Freed in ffs_data_put+0x25c/0x320 age=0 cpu=3 pid=4650
>     free_debug_processing+0x22c/0x434
>     __slab_free+0x2d8/0x3a0
>     kfree+0x254/0x264
>     ffs_data_put+0x25c/0x320
>     ffs_data_closed+0x124/0x15c
>     ffs_fs_kill_sb+0xb8/0x110
>     deactivate_locked_super+0x6c/0x98
>     deactivate_super+0xb0/0xbc
> INFO: Object 0xffffffc057938600 @offset=1536 fp=0x          (null)
> ......
> Call trace:
> [<ffffff900808cf5c>] dump_backtrace+0x0/0x250
> [<ffffff900808d3a0>] show_stack+0x14/0x1c
> [<ffffff90084a8c04>] dump_stack+0xa0/0xc8
> [<ffffff900826c2b4>] print_trailer+0x158/0x260
> [<ffffff900826d9d8>] object_err+0x3c/0x40
> [<ffffff90082745f0>] kasan_report_error+0x2a8/0x754
> [<ffffff9008274f84>] kasan_report+0x5c/0x60
> [<ffffff9008273208>] __asan_load4+0x70/0x88
> [<ffffff90084cd81c>] refcount_dec_and_test+0x14/0xe0
> [<ffffff9008d98f9c>] ffs_data_put+0x80/0x320
> [<ffffff9008d9d904>] ffs_fs_kill_sb+0xc8/0x110
> [<ffffff90082852a0>] deactivate_locked_super+0x6c/0x98
> [<ffffff900828537c>] deactivate_super+0xb0/0xbc
> [<ffffff90082af0c0>] cleanup_mnt+0x64/0xec
> [<ffffff90082af1b0>] __cleanup_mnt+0x10/0x18
> [<ffffff90080d9e68>] task_work_run+0xcc/0x124
> [<ffffff900808c8c0>] do_notify_resume+0x60/0x70
> [<ffffff90080866e4>] work_pending+0x10/0x14
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xinyong <xinyong.fang@linux.alibaba.com>
> ---
>  drivers/usb/gadget/function/f_fs.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c
> b/drivers/usb/gadget/function/f_fs.c
> index c2592d8..d2428a9 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -1538,7 +1538,6 @@ static int ffs_fs_parse_opts(struct ffs_sb_fill_data
> *data, char *opts)
>         if (sb->s_fs_info) {
>                 ffs_release_dev(sb->s_fs_info);
>                 ffs_data_closed(sb->s_fs_info);
> -               ffs_data_put(sb->s_fs_info);
>         }
>  }
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a11401f28c932ee0566b9894c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi,=C2=A0<span style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:14px;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing=
:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-d=
ecoration-color:initial;float:none;display:inline">balbi and<span style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:14px;font-style:=
normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:4=
00;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial;float:none;displa=
y:inline"><span>=C2=A0</span></span><span style=3D"color:rgb(34,34,34);font=
-family:arial,sans-serif;font-size:14px;font-style:normal;font-variant-liga=
tures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal=
;text-align:start;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline">folks,</span><=
/span><div><span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;=
font-size:14px;font-style:normal;font-variant-ligatures:normal;font-variant=
-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-in=
dent:0px;text-transform:none;white-space:normal;word-spacing:0px;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial;float:none;display:inline"><br></span></div><div><span style=3D"fo=
nt-size:14px">could you<span style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:14px;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline">=C2=A0</span>help review or=
 comment for the change. thanks</span></div><div><span style=3D"font-size:1=
4px"><br></span></div><div><span style=3D"font-size:14px">-</span></div><di=
v><span style=3D"font-size:14px">xinyong</span></div><div><span style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:14px;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline"><br></span></div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">2018-03-02 19:20 GMT+08:00 Xinyong <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:xinyong.fang@linux.alibaba.com" target=3D"_blank">xinyong.fan=
g@linux.alibaba.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">When =
I debug a kernel crash issue in funcitonfs, found ffs_data.ref<br>
overflowed, While functionfs is unmounting, ffs_data is put twice.<br>
<br>
Commit 43938613c6fd (&quot;drivers, usb: convert ffs_data.ref from atomic_t=
 to<br>
refcount_t&quot;) can avoid refcount overflow, but that is risk some situat=
ions.<br>
So no need put ffs data in ffs_fs_kill_sb, already put in ffs_data_closed.<=
br>
<br>
The issue can be reproduced in Mediatek mt6763 SoC, ffs for ADB device.<br>
KASAN enabled configuration reports use-after-free errro.<br>
<br>
BUG: KASAN: use-after-free in refcount_dec_and_test+0x14/<wbr>0xe0 at addr =
ffffffc0579386a0<br>
Read of size 4 by task umount/4650<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>
BUG kmalloc-512 (Tainted: P=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O=C2=A0 =C2=
=A0): kasan: bad access detected<br>
------------------------------<wbr>------------------------------<wbr>-----=
------------<br>
<br>
INFO: Allocated in ffs_fs_mount+0x194/0x844 age=3D22856 cpu=3D2 pid=3D566<b=
r>
=C2=A0 =C2=A0 alloc_debug_processing+0x1ac/<wbr>0x1e8<br>
=C2=A0 =C2=A0 ___slab_alloc.constprop.63+<wbr>0x640/0x648<br>
=C2=A0 =C2=A0 __slab_alloc.isra.57.<wbr>constprop.62+0x24/0x34<br>
=C2=A0 =C2=A0 kmem_cache_alloc_trace+0x1a8/<wbr>0x2bc<br>
=C2=A0 =C2=A0 ffs_fs_mount+0x194/0x844<br>
=C2=A0 =C2=A0 mount_fs+0x6c/0x1d0<br>
=C2=A0 =C2=A0 vfs_kern_mount+0x50/0x1b4<br>
=C2=A0 =C2=A0 do_mount+0x258/0x1034<br>
INFO: Freed in ffs_data_put+0x25c/0x320 age=3D0 cpu=3D3 pid=3D4650<br>
=C2=A0 =C2=A0 free_debug_processing+0x22c/<wbr>0x434<br>
=C2=A0 =C2=A0 __slab_free+0x2d8/0x3a0<br>
=C2=A0 =C2=A0 kfree+0x254/0x264<br>
=C2=A0 =C2=A0 ffs_data_put+0x25c/0x320<br>
=C2=A0 =C2=A0 ffs_data_closed+0x124/0x15c<br>
=C2=A0 =C2=A0 ffs_fs_kill_sb+0xb8/0x110<br>
=C2=A0 =C2=A0 deactivate_locked_super+0x6c/<wbr>0x98<br>
=C2=A0 =C2=A0 deactivate_super+0xb0/0xbc<br>
INFO: Object 0xffffffc057938600 @offset=3D1536 fp=3D0x=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (null)<br>
......<br>
Call trace:<br>
[&lt;ffffff900808cf5c&gt;] dump_backtrace+0x0/0x250<br>
[&lt;ffffff900808d3a0&gt;] show_stack+0x14/0x1c<br>
[&lt;ffffff90084a8c04&gt;] dump_stack+0xa0/0xc8<br>
[&lt;ffffff900826c2b4&gt;] print_trailer+0x158/0x260<br>
[&lt;ffffff900826d9d8&gt;] object_err+0x3c/0x40<br>
[&lt;ffffff90082745f0&gt;] kasan_report_error+0x2a8/0x754<br>
[&lt;ffffff9008274f84&gt;] kasan_report+0x5c/0x60<br>
[&lt;ffffff9008273208&gt;] __asan_load4+0x70/0x88<br>
[&lt;ffffff90084cd81c&gt;] refcount_dec_and_test+0x14/<wbr>0xe0<br>
[&lt;ffffff9008d98f9c&gt;] ffs_data_put+0x80/0x320<br>
[&lt;ffffff9008d9d904&gt;] ffs_fs_kill_sb+0xc8/0x110<br>
[&lt;ffffff90082852a0&gt;] deactivate_locked_super+0x6c/<wbr>0x98<br>
[&lt;ffffff900828537c&gt;] deactivate_super+0xb0/0xbc<br>
[&lt;ffffff90082af0c0&gt;] cleanup_mnt+0x64/0xec<br>
[&lt;ffffff90082af1b0&gt;] __cleanup_mnt+0x10/0x18<br>
[&lt;ffffff90080d9e68&gt;] task_work_run+0xcc/0x124<br>
[&lt;ffffff900808c8c0&gt;] do_notify_resume+0x60/0x70<br>
[&lt;ffffff90080866e4&gt;] work_pending+0x10/0x14<br>
<br>
Cc: <a href=3D"mailto:stable@vger.kernel.org">stable@vger.kernel.org</a><br=
>
Signed-off-by: Xinyong &lt;<a href=3D"mailto:xinyong.fang@linux.alibaba.com=
">xinyong.fang@linux.alibaba.<wbr>com</a>&gt;<br>
---<br>
=C2=A0drivers/usb/gadget/function/f_<wbr>fs.c |=C2=A0 =C2=A0 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/usb/gadget/function/<wbr>f_fs.c b/drivers/usb/gadget/f=
unction/<wbr>f_fs.c<br>
index c2592d8..d2428a9 100644<br>
--- a/drivers/usb/gadget/function/<wbr>f_fs.c<br>
+++ b/drivers/usb/gadget/function/<wbr>f_fs.c<br>
@@ -1538,7 +1538,6 @@ static int ffs_fs_parse_opts(struct ffs_sb_fill_data =
*data, char *opts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sb-&gt;s_fs_info) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ffs_release_dev(sb-=
&gt;s_fs_info)<wbr>;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ffs_data_closed(sb-=
&gt;s_fs_info)<wbr>;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ffs_data_put(sb-&gt=
;s_fs_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.9.5<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-usb&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<wbr>m=
ajordomo-info.html</a><br>
</font></span></blockquote></div><br></div>

--001a11401f28c932ee0566b9894c--
