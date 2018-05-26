Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032138AbeEZQdn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 12:33:43 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55871 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031950AbeEZQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 12:33:42 -0400
X-Google-Smtp-Source: ADUXVKJyan9DhkJ9Ne/NDdS3lFhvq8WacdlRZ3P9RNpm2Y/rZImMSYVWdEJXFhSA+v3v9JACOM69hXOhvoPQ65Cy1gc=
MIME-Version: 1.0
From: Lei Chen <losemyheaven@gmail.com>
Date: Sun, 27 May 2018 00:33:40 +0800
Message-ID: <CAKEZqKJhZNoF-29ymEmAjiYfVn64q5mHrMY9sC2NZ=EDqTHjeA@mail.gmail.com>
Subject: Why does d_splice_alias need to check IS_ROOT?
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I'm insteresting in how hard link and denry lookup work and their
implementation.

I know that this interface tries to connect an inode to a dentry, but
why does it need
to check whether the inode alias IS_ROOT if the inode represents a directory?
And the code process in different way according to check result.  What
occasions
are they used for?

struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
{
    if (S_ISDIR(inode->i_mode)) {
        struct dentry *new = __d_find_any_alias(inode);
        if (unlikely(new)) {
            if (unlikely(d_ancestor(new, dentry))) {
                /*the code here is to forbidden ancestor hard link*/
            } else if (!IS_ROOT(new)) {
                __d_unalias(inode, dentry, new);
            } else {
                __d_move(new, dentry, false);
            }

        }


    }
}

Thanks in advance.

Regards,
Larry
