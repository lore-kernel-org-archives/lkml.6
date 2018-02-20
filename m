Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeBTXjt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:39:49 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:51258 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeBTXjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:39:39 -0500
X-Google-Smtp-Source: AH8x2272F9og1eELoY5MeGS0S6C8Jq4oDUGB9M2rnaw3JGrQbm0V3kCSi9gz1DT2WVC57lllroBgHeBBZSXSNRjMKjI=
MIME-Version: 1.0
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk> <CA+55aFzjyB=E+=q-W9oYZ7Py7nJwm8YQHFjfbWTib6wvkP9B_A@mail.gmail.com>
 <20180220233008.55rfm7zw62hrao5p@agluck-desk>
In-Reply-To: <20180220233008.55rfm7zw62hrao5p@agluck-desk>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 20 Feb 2018 23:39:27 +0000
Message-ID: <CACdnJussCnLqdGGyOc=iUwEdot_U2DZjGcVWRcQa-DxVcUhabA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: tony.luck@intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        joe.konno@linux.intel.com, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, matthew.garrett@nebula.com,
        Jeremy Kerr <jk@ozlabs.org>, ak@linux.intel.com, pjones@redhat.com,
        luto@kernel.org,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 3:30 PM Luck, Tony <tony.luck@intel.com> wrote:
> [1] I didn't dig through the Linux code to check whether we manage to
> get those four SMIs from a single EFI call, or whether we make multiple
> EFI calls to open/read/close one file. It is possible that we stink a
> bit too if we are doing more EFI calls than required.

read() will make two calls - one to obtain the size of the variable, the
other to read it. It looks like cat will also trigger an fstat(), so we're
probably also making a call for that. There's presumably some optimisation
that could be made there if we trust the firmware not to change the size
behind our back.
