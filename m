Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755013AbeBURtQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:49:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54372 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966069AbeBURtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:49:13 -0500
Date: Wed, 21 Feb 2018 17:49:10 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: SVM: Fix sparse: incorrect type in argument 1
 (different base types)
Message-ID: <20180221174910.GI30522@ZenIV.linux.org.uk>
References: <20180219161228.46931-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219161228.46931-1-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:12:28AM -0600, Brijesh Singh wrote:
> Fix sparse: incorrect type in argument 1 (different base types). Typecast
> the userspace address argument.

Better question: why the hell do we want that access_ok(), anyway?  The only
thing we do to params.uaddr is
        if (blob) {
                if (copy_to_user((void __user *)(uintptr_t)params.uaddr, blob, params.len))
                        ret = -EFAULT;
        }

downstream.  What does that access_ok() buy us?  It does not guarantee that
copy_to_user() won't fail.  It does not clamp params.len (we'd just done
that explicitly).  So why not somethings like this:

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3e488a74828..ba2c1a606985 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6239,13 +6239,15 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	struct kvm_sev_info *sev = &kvm->arch.sev_info;
 	struct sev_data_launch_measure *data;
 	struct kvm_sev_launch_measure params;
+	void __user *measure = (void __user *)(uintptr_t)argp->data;
+	void __user *p = NULL;
 	void *blob = NULL;
 	int ret;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+	if (copy_from_user(&params, measure, sizeof(params)))
 		return -EFAULT;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -6256,17 +6258,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!params.len)
 		goto cmd;
 
-	if (params.uaddr) {
+	p = (void __user *)(uintptr_t)params.uaddr;
+	if (p) {
 		if (params.len > SEV_FW_BLOB_MAX_SIZE) {
 			ret = -EINVAL;
 			goto e_free;
 		}
 
-		if (!access_ok(VERIFY_WRITE, params.uaddr, params.len)) {
-			ret = -EFAULT;
-			goto e_free;
-		}
-
 		ret = -ENOMEM;
 		blob = kmalloc(params.len, GFP_KERNEL);
 		if (!blob)
@@ -6290,13 +6288,13 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_free_blob;
 
 	if (blob) {
-		if (copy_to_user((void __user *)(uintptr_t)params.uaddr, blob, params.len))
+		if (copy_to_user(p, blob, params.len))
 			ret = -EFAULT;
 	}
 
 done:
 	params.len = data->len;
-	if (copy_to_user((void __user *)(uintptr_t)argp->data, &params, sizeof(params)))
+	if (copy_to_user(measure, &params, sizeof(params)))
 		ret = -EFAULT;
 e_free_blob:
 	kfree(blob);
