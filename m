Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E34C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589552082F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfBCVUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 16:20:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:58002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbfBCVUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 16:20:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32D3DAD6B;
        Sun,  3 Feb 2019 21:20:00 +0000 (UTC)
Date:   Sun, 3 Feb 2019 22:19:58 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/3] scripts/ima: define a set of common functions
Message-ID: <20190203211958.GB4022@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548960936-7800-3-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> Define and move get_secureboot_mode() to a common file for use by other
> tests.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  tools/testing/selftests/ima/common_lib.sh      | 20 ++++++++++++++++++++
>  tools/testing/selftests/ima/test_kexec_load.sh | 17 +++--------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>  create mode 100755 tools/testing/selftests/ima/common_lib.sh

> diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
> new file mode 100755
> index 000000000000..ae097a634da5
> --- /dev/null
> +++ b/tools/testing/selftests/ima/common_lib.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
# SPDX-License-Identifier: GPL-2.0-or-later

> +
> +get_secureboot_mode()
> +{
> +	EFIVARFS="/sys/firmware/efi/efivars"
	local efivarfs="/sys/firmware/efi/efivars"
	local file
It's a good practise to use local keyword and lower case the name of the
variable for variables used only locally (if you treat $EFIVARFS as constant,
I'd move it outside of get_secureboot_mode()).
I personally try to avoid using global variables (except constant like).

> +	# Make sure that efivars is mounted in the normal location
> +	if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
> +		echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
> +		exit $ksft_skip
> +	fi
There could be helper function printing error and exit in selftest library.

> +	# Get secureboot mode
> +	file="$EFIVARFS/SecureBoot-*"
	file="$efivarfs/SecureBoot-*"

...
>  KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
Another candidate for helper for potential selftest library.

Kind regards,
Petr
