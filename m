Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224G/TbWRCQ0OxB57tmnaEGHRv+oMOdwbYnUbC46oSzFKBS5Df2c1LR+d3w00/Hl6cln4/JV
ARC-Seal: i=1; a=rsa-sha256; t=1519217935; cv=none;
        d=google.com; s=arc-20160816;
        b=NYPEBO5/8ZvrnMKOluPO0JOzVNGuTF2uGPzqT2JFXYIjoEu1WhachdzKW9mRW1Q5oX
         ypAyTXdg3xQQoNj4JJlYAogcRX1pP1uJzxOYJzqYim2RDWJ1TYd5Vt8TJ/NjhkMcWKgc
         YxtdmNdMzyezo9Fk5iCEHh7mLgUoMgGTgvAMdyJBPIvN5tbk3N/MwKscatlD+vTI/PRF
         5FOp/uGMsXDvp9zsX/bax+t//AK/eAhsTgaEFA1ZmjOuKJSKqK0Xr5lrS6++GM55gUM8
         m32+PH1p1+vQtUf0Gi/NWI02dcHNM1ErkLW2LgrEYuMPM6Fp4B3iX9xEO4ecc/UdPtKV
         nGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M0+ZOJmjhZ9j9ypa+bdwWTM5G/3iF5tVhfLygwwaZrg=;
        b=WS1GzdQ1Cl/qPuSPJRO3jlExi3HGj+pxA5o8gBTFjEW2TdbNGxYi5zihJLog6xeRAR
         gMfndypAawz7yiF9o1WaDuZh8KJvEnQExN37mWtOYAC/2R/UItPToxI9jsCWK+h7wZnw
         2BM+YMkIL2UfFcPKMXU3OFM/mmWlRqcYFQ0q3DAWbhGzoTAQH6KKIWuE/nFoo2RhMDa3
         iXQ1iD/kyyg0SpH1pj3ZqDCWbZkz8dKiWdYOUbiSxMArgXvDTq8iXHMxih+xsYpqFUpj
         hlJaktstee2eF7BZEPmE4wP6k7gCtk2/1LgLVfpAe0spS06JIK4ctfgR+9BUcUcWZHgd
         JGcQ==
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
Subject: [PATCH 4.14 003/167] IB/umad: Fix use of unprotected device pointer
Date: Wed, 21 Feb 2018 13:46:54 +0100
Message-Id: <20180221124524.804122868@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015466808689582?=
X-GMAIL-MSGID: =?utf-8?q?1593015466808689582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
