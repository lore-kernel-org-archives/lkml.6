Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeC2XCy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 19:02:54 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:45191 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeC2XCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 19:02:47 -0400
X-Google-Smtp-Source: AIpwx4+rpPT7S4Ryy+cpmwgpGMXNgZYVqoH0gN0mGUbpX5GWzY9778zMCka6GU6KJrJ/c/quXeaBTqT6FWJQigL5B6A=
MIME-Version: 1.0
In-Reply-To: <20180329160215.glnrmyunujcc4vwg@quack2.suse.cz>
References: <152167302988.5268.4370226749268662682.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152167306807.5268.8483232024444414342.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180329160215.glnrmyunujcc4vwg@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 29 Mar 2018 16:02:45 -0700
Message-ID: <CAPcyv4jK92ev=yWaKCUdxN5z+4+feH+ts3j6KHk57bZVu_QqYQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/14] fs, dax: use page->mapping to warn if truncate
 collides with a busy page
To: Jan Kara <jack@suse.cz>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 9:02 AM, Jan Kara <jack@suse.cz> wrote:
> On Wed 21-03-18 15:57:48, Dan Williams wrote:
[..]
> I find it quite tricky that in case we pass zero page / empty entry into
> dax_[dis]associate_entry(), it will not do anything because
> dax_entry_size() will return 0. Can we add an explicit check into
> dax_[dis]associate_entry() or at least a comment there?

How about the following, i.e. rename the loop helper to
for_each_dax_pfn() to make it clearer that we're only operating on
mapped pfns, and also add a comment to indicate the same:

/*
 * Iterate through all mapped pfns represented by an entry, i.e. skip
 * 'empty' and 'zero' entries.
 */
#define for_each_dax_pfn(entry, pfn) \
        for (pfn = dax_radix_pfn(entry); \
                        pfn < dax_radix_end_pfn(entry); pfn++)
