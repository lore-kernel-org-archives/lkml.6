Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Y81zAkEhIEVTgilKboZDoVw+gK5+xvBvuYBr+O2wSjgmhVql+IHHYNN+2QRlRzoELV0e+
ARC-Seal: i=1; a=rsa-sha256; t=1519218377; cv=none;
        d=google.com; s=arc-20160816;
        b=M7Jy+18rrQ5v6fqRqcGHrAlwNdTc+OFALuHuuhJRMZ74RJwmRC9ZaDL/sGMXbUnRvg
         NWWyqo83f8FUusn+bBWTpfJNufkKXYvLS2ZLJYBVkVwuSb43TtUnNzyeRGAetd/nsUfx
         HgHMc5ETr7zu15lmwKH56qHrTSOeqgytJwyyiYkVlvd2bTznNmXROGsJpCvZ1gujwrni
         DLlUMBJ0QKP27LOMYgOoknTTacxGJ9xHP6xjeJv9CP7ImwH2NMvsCvo1Ci3ZR/t6YFhZ
         tcfiEQuxbUAVfIzBkFg0ojEhyljfajs6UY//I07GqApGCftKIh7MGj87XCDoG6T7AVFk
         0zoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y80s4MZGfPV3sGUwrz3BIrahDQXQ1rHq/xFfAJmEfL0=;
        b=itewKrA6dgxZ9iNlUSE02eMTrdvhe/6WUwUcMUKv7apkdZrzzUhr9eLt41edOdOnYJ
         Q5YA13p7a4LupluN9Wjw9CGqNjHsSgGjw0EJvwX66psmhXRuk7o4BC/kgq2qrXy4tyBx
         pZTS+R09I85dyc+NNSW8hPY4fpTMevrObWjt3ojM4V1OcuqA1F0p3IFChlGO2snK0nyG
         Zug5/zli5ktA0Tj+Nlu+4Nj7SzorkdfBBRCtr8vxysLRZ6ZC5hDQhYuH3KrkzPWWdW1h
         Th/qIggl8JCC0aEsJxuG7zoOucz+JG9ywIzrQEkGA2I6o2y3RcubviFIPCMh9kbAW44L
         6Iag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 002/163] IB/umad: Fix use of unprotected device pointer
Date: Wed, 21 Feb 2018 13:47:11 +0100
Message-Id: <20180221124530.075643868@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015466808689582?=
X-GMAIL-MSGID: =?utf-8?q?1593015929148606248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit f23a5350e43c810ca36b26d4ed4ecd9a08686f47 upstream.

The ib_write_umad() is protected by taking the umad file mutex.
However, it accesses file->port->ib_dev -- which is protected only by the
port's mutex (field file_mutex).

The ib_umad_remove_one() calls ib_umad_kill_port() which sets
port->ib_dev to NULL under the port mutex (NOT the file mutex).
It then sets the mad agent to "dead" under the umad file mutex.

This is a race condition -- because there is a window where
port->ib_dev is NULL, while the agent is not "dead".

As a result, we saw stack traces like:

[16490.678059] BUG: unable to handle kernel NULL pointer dereference at 00000000000000b0
[16490.678246] IP: ib_umad_write+0x29c/0xa3a [ib_umad]
[16490.678333] PGD 0 P4D 0
[16490.678404] Oops: 0000 [#1] SMP PTI
[16490.678466] Modules linked in: rdma_ucm(OE) ib_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_uverbs(OE) ib_umad(OE) mlx4_en(OE) ptp pps_core mlx4_ib(OE-) ib_core(OE) mlx4_core(OE) mlx_compat
(OE) memtrack(OE) devlink mst_pciconf(OE) mst_pci(OE) netconsole nfsv3 nfs_acl nfs lockd grace fscache cfg80211 rfkill esp6_offload esp6 esp4_offload esp4 sunrpc kvm_intel kvm ppdev parport_pc irqbypass
parport joydev i2c_piix4 virtio_balloon cirrus drm_kms_helper ttm drm e1000 serio_raw virtio_pci virtio_ring virtio ata_generic pata_acpi qemu_fw_cfg [last unloaded: mlxfw]
[16490.679202] CPU: 4 PID: 3115 Comm: sminfo Tainted: G           OE   4.14.13-300.fc27.x86_64 #1
[16490.679339] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu2 04/01/2014
[16490.679477] task: ffff9cf753890000 task.stack: ffffaf70c26b0000
[16490.679571] RIP: 0010:ib_umad_write+0x29c/0xa3a [ib_umad]
[16490.679664] RSP: 0018:ffffaf70c26b3d90 EFLAGS: 00010202
[16490.679747] RAX: 0000000000000010 RBX: ffff9cf75610fd80 RCX: 0000000000000000
[16490.679856] RDX: 0000000000000001 RSI: 00007ffdf2bfd714 RDI: ffff9cf6bb2a9c00

In the above trace, ib_umad_write is trying to dereference the NULL
file->port->ib_dev pointer.

Fix this by using the agent's device pointer (the device field
in struct ib_mad_agent) -- which IS protected by the umad file mutex.

Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/user_mad.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -500,7 +500,7 @@ static ssize_t ib_umad_write(struct file
 	}
 
 	memset(&ah_attr, 0, sizeof ah_attr);
-	ah_attr.type = rdma_ah_find_type(file->port->ib_dev,
+	ah_attr.type = rdma_ah_find_type(agent->device,
 					 file->port->port_num);
 	rdma_ah_set_dlid(&ah_attr, be16_to_cpu(packet->mad.hdr.lid));
 	rdma_ah_set_sl(&ah_attr, packet->mad.hdr.sl);
