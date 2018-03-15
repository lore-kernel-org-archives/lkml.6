Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbeCOTBX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:01:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39876 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752571AbeCOTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:01:09 -0400
Message-ID: <1521140467.5348.94.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH v2 1/3] ima: extend clone() with IMA namespace
 support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mkayaalp@cs.binghamton.edu,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>, sunyuqiong1988@gmail.com,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        david.safford@ge.com, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com
Date: Thu, 15 Mar 2018 12:01:07 -0700
In-Reply-To: <0dc5b856-8dc6-7b5a-eeac-febd19f6498c@linux.vnet.ibm.com>
References: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
         <20180309201421.6150-2-stefanb@linux.vnet.ibm.com>
         <87vadxfwqj.fsf@xmission.com>
         <c18b6e92-57f0-5994-eb60-5fadc6671832@linux.vnet.ibm.com>
         <1521135192.5348.64.camel@HansenPartnership.com>
         <2183a3b4-6270-d2e9-70ad-a7399eb1681c@linux.vnet.ibm.com>
         <1521139535.5348.89.camel@HansenPartnership.com>
         <0dc5b856-8dc6-7b5a-eeac-febd19f6498c@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 14:51 -0400, Stefan Berger wrote:
> On 03/15/2018 02:45 PM, James Bottomley wrote:
[...]
> > > > going to need some type of keyring namespace and there's
> > > > already
> > > > one hanging off the user_ns:
> > > > 
> > > > commit f36f8c75ae2e7d4da34f4c908cebdb4aa42c977e
> > > > Author: David Howells <dhowells@redhat.com>
> > > > Date:   Tue Sep 24 10:35:19 2013 +0100
> > > > 
> > > >       KEYS: Add per-user_namespace registers for persistent
> > > > per-UID
> > > > kerberos caches
> > > The benefit for IMA would be that this would then tie the keys
> > > needed for appraising to the IMA namespace's policy.
> > > However, if you have an appraise policy in your IMA namespace,
> > > which is now hooked to the user namespace, and you join that user
> > > namespace but your files don't have signatures, nothing will
> > > execute anymore. That's now a side effect of joining this user
> > > namespace unless we have a magic  exception. My feeling is,
> > > people may not like that...
> > Agree, but I think the magic might be to populate the ima keyring
> > with the parent on user_ns creation.  That way the user_ns owner
> > can delete the parent keys if they don't like them, but by default
> > the parent appraisal policy should just work.
> 
> That may add keys to your keyring but doesn't get you signatures on
> your  files.

But it doesn't need to.  The only way we'd get a failure is if the file
is already being appraised and we lose access to the key.  If the
parent policy isn't appraisal, entering the IMA NS won't cause
appraisal to be turned on unless the owner asks for it, in which case
it's caveat emptor: As it works today, if as root I add a default
appraisal policy to IMA without either a key or xattrs, I get an
unusable system.

James
