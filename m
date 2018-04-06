Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iBZHr86AS0tHiRAbi444nu8UDUUk/bHCdrlzfBiu3B474Ozo0kiQFp3ooEXGYc+YF95Vb
ARC-Seal: i=1; a=rsa-sha256; t=1523021635; cv=none;
        d=google.com; s=arc-20160816;
        b=w7pW3YfwAKt6RzRYYkJDhPMoBOHr+15y5tP7gQm0oD08kuZXc9m9BgMQuV6ZWfmYfb
         BTkiiFuSTQeBqyWutPK5Q7rd3aV/7+q7wiFiT8mc79mPLJB/v4WBFtADJKtKM5AAZNN6
         4Am2SSqGH4XBh5mEKf7NHlLTL1yRlO0k60NgwRAwI5MVkDotKRStCc6EH0ZmWWO2WvHo
         FiL9ImwZ/OwINC+Mb3M6AgRJ8htQzWMVP1sN4xyunOIbGpbqyTvUG4EF0i/aySUyZqoj
         N1T2s1/ROJ0IfRp4kQBX4kOLUuKfoInl1Pz1oeEjf5xm2QOG3cvuxVN6uLvxLwI8fRcl
         kWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4Up6+U2L55+/O5gs0KCgUOLBZ4vH3e2vJEg5zQPlxlo=;
        b=eVWGHHGwNsh5QufPw3Pwxz3HERGbAa4KA9jLPWTgy4HHzOy8yuJKuZN6ZLMJ2SwOM9
         OI3IaTiX9vML/g7l06pjZONAAUplSMtDGR+kiFbu6YqkBUewjy2f6dtkRwstqcXJ6ke7
         E1hggr3y6KEZUM3kqPXhhY0MQD9kaSH5TIAL/xX9t+3z+T3ijO19PQUd6WCF+2bbQcHf
         aabMAGED5hE4lZd5PhwLPYAzlqXHqAOWGH9KL7NhnstSBM+Z5TP0iZ9McyJzbeez4MsV
         T2GDFqpVZbRjrJvGhTl1PoROh2Mb2yrAV9dKp/ljUQw9D6DpiukBSSlPNb98iP3frKGD
         Q14w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Manfred Spraul <manfred@colorfullife.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 008/102] ipc/shm.c: add split function to shm_vm_ops
Date: Fri,  6 Apr 2018 15:22:49 +0200
Message-Id: <20180406084332.690189179@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003934238227068?=
X-GMAIL-MSGID: =?utf-8?q?1597003934238227068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 3d942ee079b917b24e2a0c5f18d35ac8ec9fee48 upstream.

If System V shmget/shmat operations are used to create a hugetlbfs
backed mapping, it is possible to munmap part of the mapping and split
the underlying vma such that it is not huge page aligned.  This will
untimately result in the following BUG:

  kernel BUG at /build/linux-jWa1Fv/linux-4.15.0/mm/hugetlb.c:3310!
  Oops: Exception in kernel mode, sig: 5 [#1]
  LE SMP NR_CPUS=2048 NUMA PowerNV
  Modules linked in: kcm nfc af_alg caif_socket caif phonet fcrypt
  CPU: 18 PID: 43243 Comm: trinity-subchil Tainted: G         C  E 4.15.0-10-generic #11-Ubuntu
  NIP:  c00000000036e764 LR: c00000000036ee48 CTR: 0000000000000009
  REGS: c000003fbcdcf810 TRAP: 0700   Tainted: G         C  E (4.15.0-10-generic)
  MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002222  XER: 20040000
  CFAR: c00000000036ee44 SOFTE: 1
  NIP __unmap_hugepage_range+0xa4/0x760
  LR __unmap_hugepage_range_final+0x28/0x50
  Call Trace:
    0x7115e4e00000 (unreliable)
    __unmap_hugepage_range_final+0x28/0x50
    unmap_single_vma+0x11c/0x190
    unmap_vmas+0x94/0x140
    exit_mmap+0x9c/0x1d0
    mmput+0xa8/0x1d0
    do_exit+0x360/0xc80
    do_group_exit+0x60/0x100
    SyS_exit_group+0x24/0x30
    system_call+0x58/0x6c
  ---[ end trace ee88f958a1c62605 ]---

This bug was introduced by commit 31383c6865a5 ("mm, hugetlbfs:
introduce ->split() to vm_operations_struct").  A split function was
added to vm_operations_struct to determine if a mapping can be split.
This was mostly for device-dax and hugetlbfs mappings which have
specific alignment constraints.

Mappings initiated via shmget/shmat have their original vm_ops
overwritten with shm_vm_ops.  shm_vm_ops functions will call back to the
original vm_ops if needed.  Add such a split function to shm_vm_ops.

Link: http://lkml.kernel.org/r/20180321161314.7711-1-mike.kravetz@oracle.com
Fixes: 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to vm_operations_struct")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Tested-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 ipc/shm.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -381,6 +381,17 @@ static int shm_fault(struct vm_area_stru
 	return sfd->vm_ops->fault(vma, vmf);
 }
 
+static int shm_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct file *file = vma->vm_file;
+	struct shm_file_data *sfd = shm_file_data(file);
+
+	if (sfd->vm_ops && sfd->vm_ops->split)
+		return sfd->vm_ops->split(vma, addr);
+
+	return 0;
+}
+
 #ifdef CONFIG_NUMA
 static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy *new)
 {
@@ -503,6 +514,7 @@ static const struct vm_operations_struct
 	.open	= shm_open,	/* callback for a new vm-area open */
 	.close	= shm_close,	/* callback for when the vm-area is released */
 	.fault	= shm_fault,
+	.split	= shm_split,
 #if defined(CONFIG_NUMA)
 	.set_policy = shm_set_policy,
 	.get_policy = shm_get_policy,
