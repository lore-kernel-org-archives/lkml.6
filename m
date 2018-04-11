Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qfEZo4mf+7vIPHPDObAEZWcs2FXXewWgLx6/JF53rWiN9u5+o6GXbFRfNWbx1ttVSNb+u
ARC-Seal: i=1; a=rsa-sha256; t=1523473019; cv=none;
        d=google.com; s=arc-20160816;
        b=H9JRLbNjmhSIUAp0VjgmsH1I9nQyGHuGJDTCHjad3ct6QJa1KbqLzAogIrab3daGmy
         gc8zd4x1vhPJeBNEW+Vw3SfNp0PYOeNVKFP2hmwPVObY8lP9tzpB0tUqXbujy/RledLt
         Cxx6sG2NMwJrk4O0SHs8zJTcy2sFYohfVKX64m9BAejzrK8dcEM2QZ8Ku0McJPY9rwvl
         L2BdbUETpsedGXLa0RfmkNpqOJH6S6tjU/AxL6T8jzKpZ0t2p4CeMrVesdd7OB33Q+Eb
         Xd1hn0EK3PRliSrNysn1vA8sXP5q34lnemnw/zR2u7nUUBzT6+1F0Iq+ukWm7S6MuKPZ
         Nn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=US19F4TMUVQurOeltrh6h5TAbv2DqxlEKtOZV3JdflI=;
        b=FYQP0ye/x50m/V2xXLmvexXq3rq0WxYgwYgP7skHG0oX+vMiY6a55bF3sU0snMCUF/
         SyeuKw/utyQzpApqDlgIteRaDdufn3lnErca5BiTSJB8UJMmZWG1BPxnDWTCF7/Wn41N
         w8Ud9VCqybzsAzKsfl8pwjMSMSFBwAHJIokkgHjSQu1JuTGr5YcgR2fbRYX3LFSlxEBl
         e9mOKUmpIVTdMJC1NjizPogzCiIziVmrWDGzQ0zS0lNplRgGs4njgUiH1mO0u1TpS8sM
         1MSWGx+BTMOtre1k6t+3GoNlIQwU0MVn9YHhmKVKOXbuiUo8hoyBeDk/RGBek2nxmqW1
         kHNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lin Zhang <xiaolou4617@gmail.com>,
	Stefan Schmidt <stefan@osg.samsung.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 099/310] net: ieee802154: fix net_device reference release too early
Date: Wed, 11 Apr 2018 20:33:58 +0200
Message-Id: <20180411183626.483368888@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476678144707595?=
X-GMAIL-MSGID: =?utf-8?q?1597477245291952666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Zhang <xiaolou4617@gmail.com>


[ Upstream commit a611c58b3d42a92e6b23423e166dd17c0c7fffce ]

This patch fixes the kernel oops when release net_device reference in
advance. In function raw_sendmsg(i think the dgram_sendmsg has the same
problem), there is a race condition between dev_put and dev_queue_xmit
when the device is gong that maybe lead to dev_queue_ximt to see
an illegal net_device pointer.

My test kernel is 3.13.0-32 and because i am not have a real 802154
device, so i change lowpan_newlink function to this:

        /* find and hold real wpan device */
        real_dev = dev_get_by_index(src_net, nla_get_u32(tb[IFLA_LINK]));
        if (!real_dev)
                return -ENODEV;
//      if (real_dev->type != ARPHRD_IEEE802154) {
//              dev_put(real_dev);
//              return -EINVAL;
//      }
        lowpan_dev_info(dev)->real_dev = real_dev;
        lowpan_dev_info(dev)->fragment_tag = 0;
        mutex_init(&lowpan_dev_info(dev)->dev_list_mtx);

Also, in order to simulate preempt, i change the raw_sendmsg function
to this:

        skb->dev = dev;
        skb->sk  = sk;
        skb->protocol = htons(ETH_P_IEEE802154);
        dev_put(dev);
        //simulate preempt
        schedule_timeout_uninterruptible(30 * HZ);
        err = dev_queue_xmit(skb);
        if (err > 0)
                err = net_xmit_errno(err);

and this is my userspace test code named test_send_data:

int main(int argc, char **argv)
{
        char buf[127];
        int sockfd;
        sockfd = socket(AF_IEEE802154, SOCK_RAW, 0);
        if (sockfd < 0) {
                printf("create sockfd error: %s\n", strerror(errno));
                return -1;
        }
        send(sockfd, buf, sizeof(buf), 0);
        return 0;
}

This is my test case:

root@zhanglin-x-computer:~/develop/802154# uname -a
Linux zhanglin-x-computer 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15
03:51:08 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
root@zhanglin-x-computer:~/develop/802154# ip link add link eth0 name
lowpan0 type lowpan
root@zhanglin-x-computer:~/develop/802154#
//keep the lowpan0 device down
root@zhanglin-x-computer:~/develop/802154# ./test_send_data &
//wait a while
root@zhanglin-x-computer:~/develop/802154# ip link del link dev lowpan0
//the device is gone
//oops
[381.303307] general protection fault: 0000 [#1]SMP
[381.303407] Modules linked in: af_802154 6lowpan bnep rfcomm
bluetooth nls_iso8859_1 snd_hda_codec_hdmi snd_hda_codec_realtek
rts5139(C) snd_hda_intel
snd_had_codec snd_hwdep snd_pcm snd_page_alloc snd_seq_midi
snd_seq_midi_event snd_rawmidi snd_req intel_rapl snd_seq_device
coretemp i915 kvm_intel
kvm snd_timer snd crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
cypted drm_kms_helper drm i2c_algo_bit soundcore video mac_hid
parport_pc ppdev ip parport hid_generic
usbhid hid ahci r8169 mii libahdi
[381.304286] CPU:1 PID: 2524 Commm: 1 Tainted: G C 0 3.13.0-32-generic
[381.304409] Hardware name: Haier Haier DT Computer/Haier DT Codputer,
BIOS FIBT19H02_X64 06/09/2014
[381.304546] tasks: ffff000096965fc0 ti: ffffB0013779c000 task.ti:
ffffB8013779c000
[381.304659] RIP: 0010:[<ffffffff01621fe1>] [<ffffffff81621fe1>]
__dev_queue_ximt+0x61/0x500
[381.304798] RSP: 0018:ffffB8013779dca0 EFLAGS: 00010202
[381.304880] RAX: 272b031d57565351 RBX: 0000000000000000 RCX: ffff8800968f1a00
[381.304987] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8800968f1a00
[381.305095] RBP: ffff8e013773dce0 R08: 0000000000000266 R09: 0000000000000004
[381.305202] R10: 0000000000000004 R11: 0000000000000005 R12: ffff88013902e000
[381.305310] R13: 000000000000007f R14: 000000000000007f R15: ffff8800968f1a00
[381.305418] FS:  00007fc57f50f740(0000) GS: ffff88013fc80000(0000)
knlGS: 0000000000000000
[381.305540] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[381.305627] CR2: 00007fad0841c000 CR3: 00000001368dd000 CR4: 00000000001007e0
[361.905734] Stack:
[381.305768]  00000000002052d0 000000003facb30a ffff88013779dcc0
ffff880137764000
[381.305898]  ffff88013779de70 000000000000007f 000000000000007f
ffff88013902e000
[381.306026]  ffff88013779dcf0 ffffffff81622490 ffff88013779dd39
ffffffffa03af9f1
[381.306155] Call Trace:
[381.306202]  [<ffffffff81622490>] dev_queue_xmit+0x10/0x20
[381.306294]  [<ffffffffa03af9f1>] raw_sendmsg+0x1b1/0x270 [af_802154]
[381.306396]  [<ffffffffa03af054>] ieee802154_sock_sendmsg+0x14/0x20 [af_802154]
[381.306512]  [<ffffffff816079eb>] sock_sendmsg+0x8b/0xc0
[381.306600]  [<ffffffff811d52a5>] ? __d_alloc+0x25/0x180
[381.306687]  [<ffffffff811a1f56>] ? kmem_cache_alloc_trace+0x1c6/0x1f0
[381.306791]  [<ffffffff81607b91>] SYSC_sendto+0x121/0x1c0
[381.306878]  [<ffffffff8109ddf4>] ? vtime_account_user+x54/0x60
[381.306975]  [<ffffffff81020d45>] ? syscall_trace_enter+0x145/0x250
[381.307073]  [<ffffffff816086ae>] SyS_sendto+0xe/0x10
[381.307156]  [<ffffffff8172c87f>] tracesys+0xe1/0xe6
[381.307233] Code: c6 a1 a4 ff 41 8b 57 78 49 8b 47 20 85 d2 48 8b 80
78 07 00 00 75 21 49 8b 57 18 48 85 d2 74 18 48 85 c0 74 13 8b 92 ac
01 00 00 <3b> 50 10 73 08 8b 44 90 14 41 89 47 78 41 f6 84 24 d5 00 00
00
[381.307801] RIP [<ffffffff81621fe1>] _dev_queue_xmit+0x61/0x500
[381.307901]  RSP <ffff88013779dca0>
[381.347512] Kernel panic - not syncing: Fatal exception in interrupt
[381.347747] drm_kms_helper: panic occurred, switching back to text console

In my opinion, there is always exist a chance that the device is gong
before call dev_queue_xmit.

I think the latest kernel is have the same problem and that
dev_put should be behind of the dev_queue_xmit.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/socket.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -304,12 +304,12 @@ static int raw_sendmsg(struct sock *sk,
 	skb->sk  = sk;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
-	dev_put(dev);
-
 	err = dev_queue_xmit(skb);
 	if (err > 0)
 		err = net_xmit_errno(err);
 
+	dev_put(dev);
+
 	return err ?: size;
 
 out_skb:
@@ -693,12 +693,12 @@ static int dgram_sendmsg(struct sock *sk
 	skb->sk  = sk;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
-	dev_put(dev);
-
 	err = dev_queue_xmit(skb);
 	if (err > 0)
 		err = net_xmit_errno(err);
 
+	dev_put(dev);
+
 	return err ?: size;
 
 out_skb:
