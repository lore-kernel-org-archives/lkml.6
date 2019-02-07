Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89543C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595A221908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGNVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:21:32 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36218 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBGNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:21:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so6421648qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=brhD3wLOOYUNlJ2g5O+FrY1UQMZBOJOtIpbq6AjVHOc=;
        b=mEHaG0T4rLmZkjcSaSCY7ZWr98lyHYbCZdQkufQQjoVmSV1fghTZi/wQ9+yRRwiWZD
         zmCIAp/9nYajcypuBvFa7WOSjCmAPE4KKyR7yG7ytqlF23VkkpvptFFO/NWDcQjKwtTk
         fKxdn22wKm7MduTbZLzJ8UXzarDLsk3gC486J70SR2duqAvqDh9Vm2Q/bZuQyinCVlKq
         /PqMR7SX3MyzgPwMkzexKPLIbjp+oJyheXy6RwU6lhLHJxG0n1jAl1yfk0pwF2uY9PXb
         ipsTpXJaVPqPR+BtF237H9ZnEJ7FxxVBpOWCwOH6q/hzS9jLxzw7qrFjLvXuK4zzKyrs
         xdkQ==
X-Gm-Message-State: AHQUAuaqmd0wscA8bg4NPGyoSaKhLDQ6LB4QuUHCru57y18bvf0ofGZM
        7P0IK3oP28y/ciT8R7J2vydBOw==
X-Google-Smtp-Source: AHgI3IZKnVOr/MbNSt200ZTDt5KacNRsWRw0udOZpWd9BQTtKUI7kW9gj+agtbgmiGc4PBqTYezNQQ==
X-Received: by 2002:a37:8a06:: with SMTP id m6mr4853567qkd.117.1549545689894;
        Thu, 07 Feb 2019 05:21:29 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id f36sm20920263qtb.67.2019.02.07.05.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 05:21:28 -0800 (PST)
Subject: Re: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check()
 helper
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1549308412.git.bristot@redhat.com>
 <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
 <20190205072220.GD21801@zn.tnic>
 <cb65e500-44dd-873c-622f-b49b9336b6a2@redhat.com>
 <20190205211348.GV21801@zn.tnic>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <30b5ffc9-9794-874b-1544-d05034b55f1b@redhat.com>
Date:   Thu, 7 Feb 2019 14:21:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205211348.GV21801@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 10:13 PM, Borislav Petkov wrote:
> On Tue, Feb 05, 2019 at 02:50:39PM +0100, Daniel Bristot de Oliveira wrote:
>>>> +		if (jump_label_can_update_check(entry, init)) {
>>>> +			arch_jump_label_transform(entry,
>>>> +						  jump_label_type(entry));
>>>
>>> Yeah, let that one stick out.
>>
>> I did not get this part...
> 
> Just let the line stick outside of the 80 cols rule which is not a hard
> one:
> 
> +          if (jump_label_can_update_check(entry, init)) {
> +                  arch_jump_label_transform(entry, jump_label_type(entry));
> 
> 
> :-)
> 

How about this?

----------------- %< ----------------------------
Subject: jump_label: Add a jump_label_can_update() helper

Move the check if a jump_entry is valid to a function.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/jump_label.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 288d630da22d..1e6f4d27e28d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -374,22 +374,29 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 	return enabled ^ branch;
 }
 
+static bool jump_label_can_update(struct jump_entry *entry, bool init)
+{
+	/*
+	 * Cannot update code that was in an init text area.
+	 */
+	if (!init || jump_entry_is_init(entry))
+		return false;
+
+	if (WARN_ONCE(!kernel_text_address(jump_entry_code(entry)),
+			 "can't patch jump_label at %pS", (void *)jump_entry_code(entry)))
+		return false;
+
+	return true;
+}
+
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
 				bool init)
 {
 	for_each_label_entry(key, entry, stop) {
-		/*
-		 * An entry->code of 0 indicates an entry which has been
-		 * disabled because it was in an init text area.
-		 */
-		if (init || !jump_entry_is_init(entry)) {
-			if (kernel_text_address(jump_entry_code(entry)))
-				arch_jump_label_transform(entry, jump_label_type(entry));
-			else
-				WARN_ONCE(1, "can't patch jump_label at %pS",
-					  (void *)jump_entry_code(entry));
+		if (jump_label_can_update(entry, init)) {
+			arch_jump_label_transform(entry, jump_label_type(entry));
 		}
 	}
 }
---------------- >% --------------------

Thanks!

-- Daniel

