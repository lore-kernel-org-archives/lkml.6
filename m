Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AB8JxZqJSBtXWjsGVF/NlfBHFzmSU21i6pLch6SnwBNZyfmj9DTRzBAZ6XKf8AfOnWHNogricGrQ
ARC-Seal: i=1; a=rsa-sha256; t=1525736671; cv=none;
        d=google.com; s=arc-20160816;
        b=zVDraxtV8X1LSExQM+a3FqEzakWCDkU6Cx76HkHCeTaXTLVK1RkiBvxH8XeCAduruu
         kS8+PCXYNfOsO/6KPFgeASqWVSsbSKfcvm4tIOakBb7CoNG+JKLupydZg4z/ghdo3oN6
         TMBYktWI78jZq3gFfJPR8TG6poaa7loL9TlS2Mbt/NtjAEoGCuk+kqo2KIo0Ky6keMP1
         cX8nuf7PPB8dHXLolRf4KVdHAq34F6gvV/KOFhQDDmrAXeM+8IPGmCTznRs+UgNCBGHA
         4BNhsQCWrrC8nwjBNDKXt016fcK+IH8zh6/91iFQc+wa7ywiWuwj5xqlE/pg7oaoDL4E
         AnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:arc-authentication-results;
        bh=wtLBaQDQHNlkIE0cTANzDIVkZH8f0FEkHNj5EiyTawQ=;
        b=MArT6gdOaajf4NfFsAir0n/3aL0G2hm4AFRRnwx2nazqU8ka1dUYa98sm8mUqndLUR
         f3kJBIl2ACYnx671EpHk0xRcE6roD7AnYlExHkACDChG8w5w4JpM+3sl/Zcj+GniwvEv
         Pxz7lm43gx1PbGozAShHfppbEKqOfXqbPtWrOSgdsmu1XRPWcrQfstNyT/5g/jJgwEWM
         eoN25VD37vifbstyeboRC+M7qW4u6ycV5DjpPLKTFe+LO4Ho00Y995GLFWdjnGrM3HtD
         4NaFlZ0PMfrnEvMBoCQLISWWIAh8T/zNCCvgela2/6tski2oV2wEbSpMzmZAJL0eHQTi
         EmXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Date: Tue, 8 May 2018 09:44:33 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nubus: Unconditionally register bus type
In-Reply-To: <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1805080904460.8@nippy.intranet>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com> <20180506045530.GA5328@kroah.com> <alpine.LNX.2.21.1805061544550.8@nippy.intranet> <20180506202018.GC8924@kroah.com> <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599850855393233563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 7 May 2018, I wrote:

> On Sun, 6 May 2018, Greg Kroah-Hartman wrote:
> 
> > > > Why not just have an "bus is registered" flag in your driver 
> > > > register function that refuses to let drivers register with the 
> > > > driver core if it isn't set?
> > > 
> > > Perhaps that should happen in the core driver_register() function. 
> > > BUG_ON is frowned upon, after all. Would that be acceptable?
> > 
> > I don't understand what you mean here, perhaps make a patch to show it?
> > 
> 
> As an alternative to your suggestion (add flag to avoid the BUG_ON):
> 
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -148,7 +148,10 @@ int driver_register(struct device_driver *drv)
>  	int ret;
>  	struct device_driver *other;
>  
> -	BUG_ON(!drv->bus->p);
> +	if (!drv->bus->p) {
> +		WARN_ONCE(1, "Cannot register driver with invalid bus\n");
> +		return -EPROBE_DEFER;
> +	}
>  
>  	if ((drv->bus->probe && drv->probe) ||
>  	    (drv->bus->remove && drv->remove) ||
> 

That rushed example I gave above seems to be confusing the issue. Sorry 
about that. (See sioux-core.c for the code that motivated it.)

This example is the sort of flag removal that I had in mind --

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ba912558a510..4ee22fb3db92 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,8 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p)
+		return -ENODEV;
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index 0b2434cc4ecd..73ff294fd449 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -19,8 +19,6 @@ static const guid_t visor_vbus_channel_guid = VISOR_VBUS_CHANNEL_GUID;
 #define LINESIZE 99
 #define POLLJIFFIES_NORMALCHANNEL 10
 
-/* stores whether bus_registration was successful */
-static bool initialized;
 static struct dentry *visorbus_debugfs_dir;
 
 /*
@@ -965,9 +963,6 @@ static int visordriver_probe_device(struct device *xdev)
  */
 int visorbus_register_visor_driver(struct visor_driver *drv)
 {
-	/* can't register on a nonexistent bus */
-	if (!initialized)
-		return -ENODEV;
 	if (!drv->probe)
 		return -EINVAL;
 	if (!drv->remove)
@@ -1212,7 +1207,6 @@ int visorbus_init(void)
 	err = bus_register(&visorbus_type);
 	if (err < 0)
 		return err;
-	initialized = true;
 	bus_device_info_init(&chipset_driverinfo, "chipset", "visorchipset");
 	return 0;
 }
@@ -1229,6 +1223,5 @@ void visorbus_exit(void)
 		visorbus_remove_instance(dev);
 	}
 	bus_unregister(&visorbus_type);
-	initialized = false;
 	debugfs_remove_recursive(visorbus_debugfs_dir);
 }

It's very hard to find examples of this pattern, where a flag is used to 
inhibit driver_register() calls. As a method of avoiding the BUG_ON this 
pattern is not popular.

Hence, the opportunities for flag removal that I mentioned are similarly 
rare. So this kind of change is not something I would propose.

Instead I would prefer either of the two solution I've previously sent, 
though any one of the 3 would actually resolve the bug reported by 
Michael.

In anycase, I'm happy to work on a new solution if it would be more 
acceptable. Would you please explain how changing the link order would 
avoid the modprobe crash? I still can't figure it out.

-- 
